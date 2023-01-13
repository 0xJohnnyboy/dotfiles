export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="tjkirch"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Nvim
export EDITOR=nvim
export NVIM_CONFIG="$HOME/.config/nvim/init.lua"

# Nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Capacitor
export CAPACITOR_ANDROID_STUDIO_PATH="/Users/johnnyboy/Library/Application Support/JetBrains/Toolbox/apps/AndroidStudio/ch-0/212.5712.43.2112.8609683"

# bun completions
[ -s "/Users/johnnyboy/.bun/_bun" ] && source "/Users/johnnyboy/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/johnnyboy/.bun"
export PATH="$BUN_INSTALL/bin:$PATH:/Users/johnnyboy/.local/share/solana/install/active_release/bin:$PATH:/Users/johnnyboy/Library/Python/3.8/bin:$PATH"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# aliases
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME" 

alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gcm="git commit -m"
alias gpl="git pull"
alias gp="git push"
alias gr="git rebase"
alias gtr="git tree"
alias gadog="git adog"
alias gl="git log"

alias dls="docker container ls"
alias drdi="docker rmi $(docker images -f "dangling=true" -q)"
alias dsa="docker stop $(docker ps -q)"

alias configure="nvim ~/.zshrc"
alias shortcuts="nvim ~/.config/skhd/skhdrc"

# functions
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
