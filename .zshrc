# oh my zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

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

# aliases
alias c="clear"
alias ll="ls -alh"
alias l="exa --long -L 1 -T --git-ignore --git --icons"
alias nv="nvim ."

alias configure="nvim ~/.zshrc"
alias refresh="source ~/.zshrc"
alias shortcuts="nvim ~/.config/skhd/skhdrc"

# git aliases
alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gco="git checkout"
alias gcm="git commit -m"
alias gpl="git pull"
alias gp="git push"
alias gr="git rebase"
alias gtr="git tree"
alias gadog="git adog"
alias gl="git log"

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME" 

# docker aliases
alias dls="docker container ls"
alias drdi="docker rmi $(docker images -f "dangling=true" -q)"
alias dsa="docker stop $(docker ps -q)"


# functions

## docker
function dx() {
    docker exec -it "$1" "$2"
}

function dsh() {
    docker exec -it "$1" sh
}
## docker end

## tmux
### returns a random word
function get_random_word() {
    local type="$1"
    local word=$(curl -s "https://random-word-form.herokuapp.com/random/$1" | jq -r ".[0]")
    echo $word
}


### creates a new session with a name and tries to attach -- uses random words or timestamp if no argument is passed
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
## tmux end

## utility
### format git files with prettier
function pfmt() {
  local option="$1"
  local files

  files=$(git diff --name-only)

  if [[ "$option" == "-u" ]]; then
    files+=($(git ls-files --others --exclude-standard))
  fi

  if [[ -z "$files" ]]; then
    echo "Aucun fichier modifié trouvé."
    return 1
  fi

  echo "Formatting files..."
  echo "$files" | xargs npx prettier --write
  echo "Done!"
}

### make dir and jump into it
function mkcd() {
    mkdir -p ${1}
    cd ${1}
    echo "created and jumped into ${1}"
}

### remove current dir
function rmc() {
    local cwd=$(pwd)
    cd ../
    rm -rf ${cwd}
    echo "${cwd} deleted"
}

### paste rs
function paste() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://paste.rs
}

### delete paste rs
function dpaste() {
    local id=${1:-/dev/stdin}
    curl -X DELETE https://paste.rs/${id}
}

### get paste rs
function gpaste() {
    local id=${1:-/dev/stdin}
    curl https://paste.rs/${id}
}

## utility end


# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"


# Load Angular CLI autocompletion.
source <(ng completion script)
export PATH="/usr/local/opt/libpq/bin:$PATH"
