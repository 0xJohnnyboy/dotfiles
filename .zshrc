# =============================================================================
# OS Detection
# =============================================================================
case "$(uname -s)" in
    Darwin*)
        export IS_MAC=true
        export IS_WSL=false
        export IS_LINUX=false
        ;;
    Linux*)
        if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null 2>&1; then
            export IS_WSL=true
            export IS_MAC=false
            export IS_LINUX=false
        else
            export IS_LINUX=true
            export IS_MAC=false
            export IS_WSL=false
        fi
        ;;
esac

# =============================================================================
# Oh My Zsh
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"

# Plugins (conditional based on OS)
if [ "$IS_MAC" = true ]; then
    plugins=(git)
else
    plugins=(git asdf vi-mode)
fi

source $ZSH/oh-my-zsh.sh

# =============================================================================
# Environment Variables
# =============================================================================

# Additional paths
export PATH="/opt/projects:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"

# Editor
export EDITOR=nvim
export NVIM_CONFIG="$HOME/.config/nvim/init.lua"

# Homebrew (macOS only)
if [ "$IS_MAC" = true ]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Zig (Linux)
if [ "$IS_LINUX" = true ] || [ "$IS_WSL" = true ]; then
    export PATH="$HOME/zig-linux-x86_64-0.14.0-dev.43+96501d338:$PATH"
fi

# Tmux-powerline configuration
[ -f "$HOME/.config/tmux-powerline/config.sh" ] && source "$HOME/.config/tmux-powerline/config.sh"

# =============================================================================
# Aliases
# =============================================================================

# General
alias c="clear"
alias ll="ls -alh"
alias l="eza --long -L 1 -a -T --git-ignore --git --icons"

# Configuration
alias configure="nvim ~/.zshrc"
alias refresh="source ~/.zshrc"

# Git
alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gco="git checkout"
alias gcm="git commit -m"
alias gpl="git pull"
alias gp="git push"
alias gr="git rebase"
alias gtr="git tree"
alias gl="git log"

# Dotfiles management
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Docker
if command -v docker &> /dev/null; then
    alias dls="docker container ls"
    alias drdi="docker rmi \$(docker images -f \"dangling=true\" -q)"
    alias dsa="docker stop \$(docker ps -q)"
fi

# OS-specific aliases
if [ "$IS_MAC" = true ]; then
    alias update="brew update && brew upgrade"
elif [ "$IS_WSL" = true ] || [ "$IS_LINUX" = true ]; then
    alias update="sudo apt update && sudo apt upgrade"
fi

# =============================================================================
# Functions
# =============================================================================

# Docker utilities
function dx() {
    docker exec -it "$1" "$2"
}

function dsh() {
    docker exec -it "$1" sh
}

# Tmux utilities
function get_random_word() {
    local type="$1"
    local word=$(curl -s "https://random-word-form.herokuapp.com/random/$1" | jq -r ".[0]")
    echo $word
}

function tmns() {
    local session_name="$1"

    if [[ -z $session_name ]]; then
        local word1=$(get_random_word adjective)
        local word2=$(get_random_word animal)

        if [[ -z $word1 ]] || [[ -z $word2 ]]; then
            session_name=$(date +"%Y%m%d%H%M%S")
        else
            session_name="${word1}-${word2}"
        fi
    fi

    echo "$session_name"
    tmux new-session -As "$session_name"
}

# Git utilities
function pfmt() {
    local option="$1"
    local files

    files=$(git diff --name-only)

    if [[ "$option" == "-u" ]]; then
        files+=($(git ls-files --others --exclude-standard))
    fi

    if [[ -z "$files" ]]; then
        echo "No modified files found."
        return 1
    fi

    echo "Formatting files..."
    echo "$files" | xargs npx prettier --write
    echo "Done!"
}

function gadog() {
    local count="$1"
    local cmd="git log --all --decorate --oneline --graph"

    if [[ "$count" ]]; then
        cmd+=" --max-count $count"
    fi
    eval "$cmd"
}

function gmf() {
    local count="${1:-1}"
    git diff --name-only HEAD HEAD~$count
}

# Utility functions
function mkcd() {
    mkdir -p "$1"
    cd "$1"
    echo "Created and jumped into $1"
}

function rmc() {
    local cwd=$(pwd)
    cd ../
    rm -rf "$cwd"
    echo "$cwd deleted"
}

# Paste.rs utilities
function paste() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://paste.rs
}

function dpaste() {
    local id=${1:-/dev/stdin}
    curl -X DELETE https://paste.rs/${id}
}

function gpaste() {
    local id=${1:-/dev/stdin}
    curl https://paste.rs/${id}
}

# Password generator (requires ~/.secure/apply_pattern.sh)
function generate_password() {
    sudo -v

    if [ $? -eq 0 ]; then
        source ~/.secure/apply_pattern.sh

        local input_string="$1"

        # Use pbcopy on macOS, xclip/xsel on Linux
        if [ "$IS_MAC" = true ]; then
            echo "$(apply_pattern $input_string)" | pbcopy
        elif command -v xclip &> /dev/null; then
            echo "$(apply_pattern $input_string)" | xclip -selection clipboard
        elif command -v xsel &> /dev/null; then
            echo "$(apply_pattern $input_string)" | xsel --clipboard --input
        else
            echo "$(apply_pattern $input_string)"
            echo "Note: No clipboard utility found. Password printed above."
        fi

        echo "Password copied!"
        unset -f apply_pattern
    else
        echo "Incorrect password"
    fi
}

alias gep="generate_password"

# =============================================================================
# Platform-specific initialization
# =============================================================================

# macOS specific
if [ "$IS_MAC" = true ]; then
    # opam configuration
    [[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null

    # Google Cloud SDK
    if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
        source "$HOME/google-cloud-sdk/path.zsh.inc"
    fi

    if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
        source "$HOME/google-cloud-sdk/completion.zsh.inc"
    fi

    # Bun completions
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
fi

# =============================================================================
# Shell enhancements
# =============================================================================

# Starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Zoxide (smart cd)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# Angular CLI autocompletion (if ng is installed)
if command -v ng &> /dev/null; then
    source <(ng completion script)
fi

# Additional tool paths (from stash)
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
