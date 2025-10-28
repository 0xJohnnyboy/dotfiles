# Ansible Automation for Dotfiles

This directory contains Ansible playbooks and roles to automatically set up a complete development environment across macOS, Linux, and WSL.

## Quick Start

### From Scratch (Recommended)

Use the curl-able bootstrap script:

```bash
curl -fsSL https://raw.githubusercontent.com/0xJohnnyboy/dotfiles/main/install.sh | bash
```

### Manual Installation

If you already have the dotfiles repo cloned:

```bash
# Install Ansible
python3 -m pip install --user ansible

# Run the full playbook
cd ~/.config/ansible
ansible-playbook playbook.yml
```

## Usage

### Install Everything

```bash
ansible-playbook playbook.yml
```

### Install Specific Components

```bash
# Install only Neovim
ansible-playbook playbook.yml --tags neovim

# Install only shell tools
ansible-playbook playbook.yml --tags shell

# Install multiple components
ansible-playbook playbook.yml --tags "git,neovim,cli"
```

### Available Tags

| Tag | Description |
|-----|-------------|
| `prereqs` | Build dependencies and compilers |
| `git` | Build git from source |
| `neovim` | Build neovim from source |
| `shell` | zsh + oh-my-zsh + starship |
| `tmux` | tmux + TPM + plugins |
| `terminal` | WezTerm terminal emulator |
| `cli` | CLI tools (ripgrep, fzf, fd, bat, eza, etc.) |
| `docker` | Docker + docker-compose |
| `languages` | Go, Node.js (nvm), Rust |
| `golang` | Go language and tools |
| `nodejs` | Node.js via nvm |
| `rust` | Rust via rustup |
| `macos` | macOS-specific tools (aerospace, skhd, etc.) |
| `dotfiles` | Apply dotfiles configuration |

### Dry Run

Preview what would be installed:

```bash
ansible-playbook playbook.yml --check
```

### Minimal Installation

Install only shell, CLI tools, and dotfiles:

```bash
ansible-playbook playbook.yml --tags "shell,cli,dotfiles"
```

## Directory Structure

```
ansible/
├── ansible.cfg              # Ansible configuration
├── inventory.ini            # Localhost inventory
├── playbook.yml             # Main playbook
├── group_vars/              # Variables
│   ├── all.yml             # Common variables
│   ├── Darwin.yml          # macOS-specific
│   └── Linux.yml           # Linux-specific
└── roles/                   # Role definitions
    ├── prerequisites/      # Build tools
    ├── git/                # Git from source
    ├── neovim/             # Neovim from source
    ├── shell/              # Shell setup
    ├── tmux/               # tmux configuration
    ├── terminal/           # WezTerm
    ├── cli_tools/          # CLI utilities
    ├── docker/             # Docker
    ├── languages/          # Programming languages
    ├── macos_tools/        # macOS window manager, etc.
    └── dotfiles/           # Apply configurations
```

## Configuration

### Customizing Versions

Edit `group_vars/all.yml` to change software versions:

```yaml
git_version: "2.47.0"
neovim_version: "0.10.2"
go_version: "1.22.5"
node_lts_version: "20"
```

### Feature Flags

Control what gets installed:

```yaml
install_docker: true         # Install Docker
install_macos_tools: true    # Install macOS window manager (aerospace)
install_languages: true      # Install Go, Node, Rust
build_from_source: true      # Build git/nvim from source vs packages
```

### Platform-Specific Settings

macOS settings in `group_vars/Darwin.yml`:
```yaml
macos_window_manager: aerospace  # or yabai, or none
macos_hotkey_daemon: skhd
macos_status_bar: sketchybar
```

Linux settings in `group_vars/Linux.yml`:
```yaml
package_manager: apt  # apt, dnf, pacman
```

## Adding New Roles

1. Create role directory:
   ```bash
   mkdir -p roles/my_role/tasks
   ```

2. Create `roles/my_role/tasks/main.yml`:
   ```yaml
   ---
   - name: Install my tool
     apt:
       name: my-tool
       state: present
     become: true
     when: ansible_os_family == "Debian"
   ```

3. Add to `playbook.yml`:
   ```yaml
   - role: my_role
     tags: [my_role]
   ```

## Troubleshooting

### Ansible Not Found

Ensure `~/.local/bin` is in your PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### Permission Errors

Some tasks require sudo. Run with:

```bash
ansible-playbook playbook.yml --ask-become-pass
```

### Build Failures

Check you have build dependencies:

```bash
ansible-playbook playbook.yml --tags prereqs
```

### Specific Role Fails

Run only that role with verbose output:

```bash
ansible-playbook playbook.yml --tags neovim -vvv
```

## Platform Support

- ✅ macOS (Intel & Apple Silicon)
- ✅ Ubuntu/Debian Linux
- ✅ WSL (Windows Subsystem for Linux)
- ⚠️ Fedora/RHEL (partial support)
- ⚠️ Arch Linux (requires customization)

## What Gets Installed

### Core Development Tools

- **Git** (latest, built from source)
- **Neovim** (latest, built from source)
- **tmux** (with TPM and powerline)
- **zsh** (with oh-my-zsh and starship prompt)
- **WezTerm** (terminal emulator)

### CLI Utilities

- **ripgrep** - Fast grep
- **fzf** - Fuzzy finder
- **fd** - Fast find
- **bat** - Better cat
- **eza** - Better ls
- **delta** - Git diff tool
- **lazygit** - Git TUI
- **gh** - GitHub CLI
- **jq/yq** - JSON/YAML processors
- **htop** - Process monitor
- **ncdu** - Disk usage analyzer

### Programming Languages

- **Go** (specified version)
- **Node.js** (via nvm, LTS version)
- **Rust** (via rustup, stable)

### Language Servers

- gopls, delve (Go)
- rust-analyzer (Rust)
- typescript-language-server (TypeScript)
- lua-language-server (Lua)

### Fonts

- JetBrainsMono Nerd Font
- Hack Nerd Font (fallback)

### macOS-Specific

- **Homebrew** (package manager)
- **aerospace** (tiling window manager)
- **skhd** (hotkey daemon)
- **sketchybar** (status bar)

## Maintenance

### Update Everything

```bash
cd ~/.config/ansible
git pull  # Update dotfiles
ansible-playbook playbook.yml  # Re-run installation
```

### Update Specific Tool

```bash
# Update version in group_vars/all.yml, then:
ansible-playbook playbook.yml --tags neovim
```

### Check for Outdated Packages

On macOS:
```bash
brew update && brew outdated
```

On Linux:
```bash
sudo apt update && apt list --upgradable
```

## Contributing

To add support for a new tool or platform:

1. Create a new role in `roles/`
2. Add OS-specific tasks with `when` conditions
3. Update `playbook.yml` to include the role
4. Test on all supported platforms
5. Document in this README

## Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Dotfiles Repository](https://github.com/0xJohnnyboy/dotfiles)
- [CLAUDE.md](../CLAUDE.md) - Overall dotfiles documentation
- [PROJECT_PLAN.md](../PROJECT_PLAN.md) - Refactoring plan and architecture
