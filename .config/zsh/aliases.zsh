# =============================================================================
# Aliases
# =============================================================================
# Command shortcuts and conveniences

# General
alias c="clear"
alias ll="ls -alh"
alias l="eza --long -L 1 -a -T --git-ignore --git --icons"

# Configuration management
alias configure="nvim ~/.zshrc"
alias refresh="source ~/.zshrc"

# Git shortcuts
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

# Dotfiles management (bare repository)
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Docker shortcuts
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

# Password generator alias
alias gep="generate_password"
