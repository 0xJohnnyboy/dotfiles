# oh my zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Nvim
export EDITOR=nvim
export NVIM_CONFIG="$HOME/.config/nvim/init.lua"
 
# node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# aliases
alias c="clear"
alias ll="ls -alh"
alias l="exa --long -L 1 -T --git-ignore --git --icons"

alias configure="nvim ~/.zshrc"
alias refresh="source ~/.zshrc"

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
alias gl="git log"

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME" 

# docker aliases
if [[ -z docker ]]; then
    alias dls="docker container ls"
    alias drdi="docker rmi $(docker images -f "dangling=true" -q)"
    alias dsa="docker stop $(docker ps -q)"
fi

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

# format git files with prettier
function pfmt() {
  local option="$1"
  local files

  # Récupérer les fichiers modifiés (staged et non staged)
  files=$(git diff --name-only)

  # Inclure les fichiers non suivis (untracked) si l'option est fournie
  if [[ "$option" == "-u" ]]; then
    files+=($(git ls-files --others --exclude-standard))
  fi

  # Vérifier s'il y a des fichiers modifiés
  if [[ -z "$files" ]]; then
    echo "Aucun fichier modifié trouvé."
    return 1
  fi

  # Exécuter la commande Prettier sur les fichiers modifiés
  echo "Formatting files..."
  echo "$files" | xargs npx prettier --write
  echo "Done!"
}

# git adog with max count
function gadog() {
    local count="$1"
    local cmd="git log --all --decorate --oneline --graph "

    if [[ "$count" ]]; then
        cmd+=" --max-count $count"
    fi
    eval "$cmd"
}

# gif modified files
function gmf() {
    local count=1

    if [[ "$count" ]]; then
        count="$1"
    fi

    local cmd="git diff --name-only HEAD HEAD~$count"
    eval "$cmd"
}

## rename multiple files
## function rnm() {
##     local matcher="*"
##     if ${3}; then
##         matcher=${3}
##     fi
##     echo "replacing everything ${matcher} - ${1} with ${2}"
##     rename 's/${1}/${2}/' ${matcher}
## }

## remove current dir
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
