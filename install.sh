#!/usr/bin/env bash
# =============================================================================
# Dotfiles Bootstrap Script
# =============================================================================
# One-command installation for development environment
# Usage: curl -fsSL https://raw.githubusercontent.com/0xJohnnyboy/dotfiles/main/install.sh | bash
# =============================================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOTFILES_DIR="$HOME/.dotfiles"
ANSIBLE_PLAYBOOK="$HOME/.config/ansible/playbook.yml"
DOTFILES_REPO=""  # Will be set based on user choice
STATE_FILE="$HOME/.dotfiles-install-state"

# =============================================================================
# Helper Functions
# =============================================================================

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

print_banner() {
    cat << 'EOF'
╔═══════════════════════════════════════════════════════════════════╗
║                                                                   ║
║   ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗  ║
║   ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝  ║
║   ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗  ║
║   ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║  ║
║   ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║  ║
║   ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝  ║
║                                                                   ║
║            Development Environment Setup Script                  ║
║                                                                   ║
╚═══════════════════════════════════════════════════════════════════╝
EOF
}

detect_os() {
    case "$(uname -s)" in
        Darwin*)
            OS="macos"
            log_info "Detected macOS"
            ;;
        Linux*)
            if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
                OS="wsl"
                log_info "Detected WSL"
            else
                OS="linux"
                log_info "Detected Linux"
            fi
            ;;
        *)
            log_error "Unsupported operating system"
            exit 1
            ;;
    esac
}

check_command() {
    command -v "$1" &> /dev/null
}

mark_step_complete() {
    local step="$1"
    echo "$step" >> "$STATE_FILE"
}

is_step_complete() {
    local step="$1"
    [ -f "$STATE_FILE" ] && grep -q "^$step$" "$STATE_FILE"
}

setup_git_access() {
    # If USE_HTTPS or USE_SSH already set by CLI args, skip prompt
    if [ -n "$USE_HTTPS" ]; then
        log_info "Using HTTPS (from --https flag)"
        DOTFILES_REPO="https://github.com/0xJohnnyboy/dotfiles.git"
        echo ""
        return
    fi

    if [ -n "$USE_SSH" ]; then
        log_info "Using SSH (from --ssh flag)"
        DOTFILES_REPO="git@github.com:0xJohnnyboy/dotfiles.git"
        # Continue to SSH key setup below
    else
        # Interactive prompt
        echo ""
        log_info "GitHub Repository Access"
        echo ""
        echo "Choose how to clone the dotfiles repository:"
        echo "  1) HTTPS (no setup required, read-only)"
        echo "  2) SSH (requires GitHub SSH key setup, read-write)"
        echo ""
        read -p "Enter choice (1 or 2): " choice < /dev/tty

        case "$choice" in
            1)
                log_info "Using HTTPS"
                DOTFILES_REPO="https://github.com/0xJohnnyboy/dotfiles.git"
                echo ""
                return
                ;;
            2)
                log_info "Using SSH"
                DOTFILES_REPO="git@github.com:0xJohnnyboy/dotfiles.git"
                ;;
            *)
                log_error "Invalid choice. Using HTTPS as default."
                DOTFILES_REPO="https://github.com/0xJohnnyboy/dotfiles.git"
                echo ""
                return
                ;;
        esac
    fi

    # SSH key setup (only reached if SSH chosen)
    if [ "$DOTFILES_REPO" = "git@github.com:0xJohnnyboy/dotfiles.git" ]; then

            # Check if SSH key exists
            if [ ! -f "$HOME/.ssh/id_ed25519" ] && [ ! -f "$HOME/.ssh/id_rsa" ]; then
                log_info "No SSH key found. Generating new ED25519 key..."
                mkdir -p "$HOME/.ssh"
                ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)" -f "$HOME/.ssh/id_ed25519" -N ""
                log_success "SSH key generated"
            else
                log_success "SSH key already exists"
            fi

            # Display the public key
            echo ""
            log_info "Your SSH public key:"
            echo ""
            if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
                cat "$HOME/.ssh/id_ed25519.pub"
            elif [ -f "$HOME/.ssh/id_rsa.pub" ]; then
                cat "$HOME/.ssh/id_rsa.pub"
            fi
            echo ""
            log_warning "Please add this key to your GitHub account:"
            echo "  1. Go to: https://github.com/settings/ssh/new"
            echo "  2. Paste the key above"
            echo "  3. Click 'Add SSH key'"
            echo ""
        read -p "Press ENTER when you've added the key to GitHub..." < /dev/tty
        log_success "Continuing with SSH"
    fi
    echo ""
}

# =============================================================================
# Installation Steps
# =============================================================================

install_git() {
    if is_step_complete "git"; then
        log_success "Git already validated (cached)"
        return
    fi

    if check_command git; then
        log_success "Git already installed: $(git --version)"
        mark_step_complete "git"
        return
    fi

    log_info "Installing git..."
    case "$OS" in
        macos)
            xcode-select --install 2>/dev/null || true
            ;;
        wsl|linux)
            sudo apt update
            sudo apt install -y git
            ;;
    esac
    log_success "Git installed"
    mark_step_complete "git"
}

install_python() {
    if is_step_complete "python"; then
        log_success "Python and pip already validated (cached)"
        return
    fi

    local python_installed=false
    local pip_installed=false

    if check_command python3; then
        log_success "Python already installed: $(python3 --version)"
        python_installed=true
    fi

    # Check if pip is available
    if python3 -m pip --version &> /dev/null; then
        log_success "pip already available"
        pip_installed=true
    fi

    # If both are installed, we're done
    if [ "$python_installed" = true ] && [ "$pip_installed" = true ]; then
        mark_step_complete "python"
        return
    fi

    log_info "Installing Python 3 and pip..."
    case "$OS" in
        macos)
            if [ "$python_installed" = false ]; then
                brew install python3
            fi
            # On macOS, pip comes with python3
            ;;
        wsl|linux)
            sudo apt update
            if [ "$python_installed" = false ]; then
                sudo apt install -y python3
            fi
            if [ "$pip_installed" = false ]; then
                sudo apt install -y python3-pip
            fi
            ;;
    esac
    log_success "Python and pip installed"
    mark_step_complete "python"
}

install_ansible() {
    if is_step_complete "ansible"; then
        log_success "Ansible already validated (cached)"
        return
    fi

    if check_command ansible-playbook; then
        log_success "Ansible already installed: $(ansible --version | head -1)"
        mark_step_complete "ansible"
        return
    fi

    log_info "Installing Ansible..."
    case "$OS" in
        macos)
            # On macOS, use pip
            python3 -m pip install --user ansible
            export PATH="$HOME/.local/bin:$PATH"
            ;;
        wsl|linux)
            # On Linux/WSL, prefer apt to avoid PEP 668 issues
            sudo apt update
            sudo apt install -y ansible
            ;;
    esac

    log_success "Ansible installed"
    mark_step_complete "ansible"
}

clone_dotfiles() {
    if is_step_complete "dotfiles"; then
        log_success "Dotfiles already cloned (cached)"
        if [ -d "$DOTFILES_DIR" ]; then
            log_info "Pulling latest changes..."
            git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" pull
        fi
        return
    fi

    if [ -d "$DOTFILES_DIR" ]; then
        log_warning "Dotfiles repository already exists at $DOTFILES_DIR"
        log_info "Pulling latest changes..."
        git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" pull
        mark_step_complete "dotfiles"
        return
    fi

    log_info "Cloning dotfiles repository..."
    git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"

    log_info "Checking out dotfiles..."

    # Backup existing files that would be overwritten
    mkdir -p "$HOME/.dotfiles-backup"
    git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" checkout main 2>&1 | \
    grep -E "^\s+" | awk '{print $1}' | \
    while read -r file; do
        mkdir -p "$HOME/.dotfiles-backup/$(dirname "$file")"
        mv "$HOME/$file" "$HOME/.dotfiles-backup/$file" 2>/dev/null || true
    done

    git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" checkout main
    git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" config status.showUntrackedFiles no

    log_success "Dotfiles checked out"
    mark_step_complete "dotfiles"
}

run_ansible() {
    log_info "Running Ansible playbook..."

    # Parse options for tags
    ANSIBLE_TAGS=""
    if [ "$MINIMAL" = true ]; then
        ANSIBLE_TAGS="--tags shell,cli,dotfiles"
        log_info "Running minimal installation (shell + cli + dotfiles)"
    elif [ -n "$TAGS" ]; then
        ANSIBLE_TAGS="--tags $TAGS"
        log_info "Running with tags: $TAGS"
    fi

    if [ "$DRY_RUN" = true ]; then
        log_info "Dry run mode - showing what would be installed"
        ANSIBLE_EXTRA="--check"
    else
        ANSIBLE_EXTRA=""
    fi

    cd "$HOME/.config/ansible"
    ansible-playbook playbook.yml $ANSIBLE_TAGS $ANSIBLE_EXTRA

    log_success "Ansible playbook completed"
}

# =============================================================================
# Main Installation
# =============================================================================

main() {
    print_banner
    echo ""

    # Parse arguments
    DRY_RUN=false
    MINIMAL=false
    TAGS=""
    SKIP_ANSIBLE=false
    USE_HTTPS=""
    USE_SSH=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            --https)
                USE_HTTPS=true
                shift
                ;;
            --ssh)
                USE_SSH=true
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --minimal)
                MINIMAL=true
                shift
                ;;
            --tags)
                TAGS="$2"
                shift 2
                ;;
            --skip-ansible)
                SKIP_ANSIBLE=true
                shift
                ;;
            --reset-cache)
                log_info "Clearing installation cache..."
                rm -f "$STATE_FILE"
                log_success "Cache cleared"
                shift
                ;;
            --help)
                cat << EOF
Usage: $0 [OPTIONS]

Options:
    --https             Use HTTPS for git clone (skip interactive prompt)
    --ssh               Use SSH for git clone (skip interactive prompt)
    --dry-run           Show what would be installed without making changes
    --minimal           Install only shell, cli tools, and dotfiles
    --tags TAGS         Run only specific Ansible tags (comma-separated)
    --skip-ansible      Only clone dotfiles, skip Ansible installation
    --reset-cache       Clear installation state cache (force re-check all steps)
    --help              Show this help message

Examples:
    $0                              # Full installation (interactive prompt)
    $0 --https                      # Use HTTPS, no prompt
    $0 --ssh                        # Use SSH with key setup, no prompt
    $0 --minimal                    # Minimal installation
    $0 --tags neovim,git            # Install only neovim and git
    $0 --dry-run                    # Preview what would be installed
    $0 --reset-cache                # Clear cache and re-check everything

Cache file location: ~/.dotfiles-install-state

EOF
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                log_info "Use --help for usage information"
                exit 1
                ;;
        esac
    done

    detect_os
    echo ""

    log_info "Step 1/7: Setting up GitHub access..."
    setup_git_access

    log_info "Step 2/7: Installing git..."
    install_git
    echo ""

    log_info "Step 3/7: Installing Python..."
    install_python
    echo ""

    log_info "Step 4/7: Installing Ansible..."
    install_ansible
    echo ""

    log_info "Step 5/7: Cloning dotfiles repository..."
    clone_dotfiles
    echo ""

    if [ "$SKIP_ANSIBLE" = false ]; then
        log_info "Step 6/7: Running Ansible playbook..."
        run_ansible
        echo ""
    else
        log_warning "Skipping Ansible playbook (--skip-ansible specified)"
        echo ""
    fi

    log_info "Step 7/7: Final setup..."

    # Add dotfiles alias to current shell session
    alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

    log_success "Installation complete!"
    echo ""

    cat << EOF
╔═══════════════════════════════════════════════════════════════════╗
║                     🎉 Setup Complete! 🎉                        ║
╚═══════════════════════════════════════════════════════════════════╝

Next steps:

  1. Reload your shell:
     ${GREEN}exec zsh${NC}

  2. Verify installations:
     git --version
     nvim --version
     tmux -V

  3. Manage your dotfiles:
     dotfiles status
     dotfiles add .config/file
     dotfiles commit -m "message"
     dotfiles push

  4. Run specific parts later:
     cd ~/.config/ansible
     ansible-playbook playbook.yml --tags neovim
     ansible-playbook playbook.yml --tags docker

Enjoy your new development environment! 🚀

EOF

    if [ -d "$HOME/.dotfiles-backup" ]; then
        log_warning "Existing files backed up to: ~/.dotfiles-backup"
    fi
}

# Run main function
main "$@"
