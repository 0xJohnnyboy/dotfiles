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
alias l="exa --long -L 1 -a -T --git-ignore --git --icons"
alias wktx="create_tmux_windows_for_worktrees"

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
alias gb="git-branch-worktree"
# alias gwp="git-pull-worktrees"

alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME" 

# docker aliases
# alias dls="docker container ls"
# alias drdi="docker rmi $(docker images -f "dangling=true" -q)"
# alias dsa="docker stop $(docker ps -q)"
# functions

## docker
# function dx() {
#     docker exec -it "$1" "$2"
# }
#
# function dsh() {
#     docker exec -it "$1" sh
# }
## docker end

## nvim
function nv() {
    local path="$1"
    if [[ -z $path ]]; then
        path="."
    fi

    nvim $path
}


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
### make dir and jump into it
function mkcd() {
    mkdir -p ${1}
    cd ${1}
    echo "created and jumped into ${1}"
}

# format git files with prettier
function pfmt() {
  local option="$1"
  local branch="$2"
  local files

  # Récupérer les fichiers modifiés (staged et non staged)
  files=$(git diff --name-only)

  if [[ "$option" == "-b" ]]; then
    if [[ -z "$branch" ]]; then
      echo "-b is missing branch name."
      return 1
    fi

    # Vérifier que la branche existe
    if ! git rev-parse --quiet --verify "$branch" > /dev/null; then
      echo "Branch '$branch' does not exist."
      return 1
    fi

    files=($(git diff $branch --name-only))
  fi

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
    local cmd="git adog"

    if [[ "$count" ]]; then
        cmd+=" --max-count $count"
    fi

    tmux neww "zsh -c \"$cmd\"; zsh"
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

function goto() {
  local search_dir="."

  if [[ "$1" ]]; then
    search_dir="$1"
  fi

  local selected_path
  selected_path=$(find "$search_dir" | zf | xargs -I {} realpath "{}")

  if [[ -n "$selected_path" ]]; then
    cd "$(dirname "$selected_path")" || return  # Change de répertoire
  else
    echo "No path selected"
  fi
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

### git create branch
gsc() {
  local type=$1
  local us_number=$2
  local name=$3
  local prefix=""

  case $type in
    ft|feat|feature)
      prefix="feat/"
      ;;
    fx|fix)
      prefix="fix/"
      ;;
    *)
      prefix=""
      ;;
  esac

  local branch_name="$prefix$us_number"
  
  if [ -n "$name" ]; then
    local formatted_name=$(echo "$name" | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g')
    branch_name="$branch_name-$formatted_name"
  fi

  git switch -c "$branch_name"
}

### git push auto set remote
gpsu() {
  # Récupérer le nom de la branche en cours
  current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)

  if [ -z "$current_branch" ]; then
    echo "Vous n'êtes pas sur une branche."
    return 1
  fi

  # Configurer l'upstream avec l'origine
  git push --set-upstream origin "$current_branch"
}

# Fonction pour créer des fenêtres tmux pour chaque worktree dans le répertoire courant
create_tmux_windows_for_worktrees() {
    local worktrees_dir=$(pwd)

    # Vérifier si le dossier des worktrees existe
    if [ -d "$worktrees_dir" ]; then
        cd "$worktrees_dir" || return

        # Liste des worktrees dans le dossier
        local worktrees=$(git worktree list --porcelain | grep -E '^worktree' | cut -d " " -f 2)

        # Créer une fenêtre tmux pour chaque worktree
        for worktree in $worktrees; do
            local window_name=$(basename "$worktree")
            echo $worktree
            tmux new-window -n "$window_name" -d -c "$worktree"
        done
    else
        echo "Le dossier des worktrees n'existe pas : $worktrees_dir"
    fi
}

function git-branch-worktree() {
    if [ $# -ne 2 ]; then
        echo "Usage: git-branch-worktree <nom_worktree> <nom_branche>"
        return 1
    fi

    local new_worktree="$1"
    local new_branch="$2"

    git branch "$new_branch" || return 1

    git worktree add "../$new_worktree" "$new_branch" || return 1

    # tmux new-window -n "$new_worktree" -c "../$new-worktree" || return 1
}

# function git-pull-worktrees() {
# # Récupérer le répertoire courant
#     current_dir=$(pwd)
#
#     # Vérifier si le répertoire courant est un worktree
#     is_worktree=$(git rev-parse --is-inside-work-tree 2>/dev/null)
#
#     # Si c'est un worktree, remonter d'un niveau
#     if [ "$is_worktree" = "true" ]; then
#         current_dir=$(dirname "$current_dir")
#     fi
#
#     # Parcourir chaque argument passé à la fonction
#     for branch_name in "$@"; do
#         # Utiliser git pour mettre à jour tous les worktrees avec la branche spécifiée
#         git worktree list --porcelain | grep -e "^worktree " | cut -d " " -f 2 | xargs -I {} sh -c "cd {} && git pull && cd $current_dir"
#     done
# }

## utility end


# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# Load Angular CLI autocompletion.
source <(ng completion script)

# bun completions
[ -s "/home/theo/.bun/_bun" ] && source "/home/theo/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fd
export PATH="$HOME/.local/bin:$PATH"

# opam configuration
test -r /home/theo/.opam/opam-init/init.zsh && . /home/theo/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
