# =============================================================================
# Custom Functions
# =============================================================================
# Utility functions for various tasks

# -----------------------------------------------------------------------------
# Docker Utilities
# -----------------------------------------------------------------------------

# Execute command in docker container
function dx() {
    docker exec -it "$1" "$2"
}

# Open shell in docker container
function dsh() {
    docker exec -it "$1" sh
}

# -----------------------------------------------------------------------------
# Tmux Utilities
# -----------------------------------------------------------------------------

# Get random word from API
function get_random_word() {
    local type="$1"
    local word=$(curl -s "https://random-word-form.herokuapp.com/random/$1" | jq -r ".[0]")
    echo $word
}

# Create or attach to tmux session with random name
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

# -----------------------------------------------------------------------------
# Git Utilities
# -----------------------------------------------------------------------------

# Format modified files with Prettier
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

# Git log with graph (All Decorate Oneline Graph)
function gadog() {
    local count="$1"
    local cmd="git log --all --decorate --oneline --graph"

    if [[ "$count" ]]; then
        cmd+=" --max-count $count"
    fi
    eval "$cmd"
}

# Git modified files (show files changed in last N commits)
function gmf() {
    local count="${1:-1}"
    git diff --name-only HEAD HEAD~$count
}

# -----------------------------------------------------------------------------
# General Utilities
# -----------------------------------------------------------------------------

# Make directory and cd into it
function mkcd() {
    mkdir -p "$1"
    cd "$1"
    echo "Created and jumped into $1"
}

# Remove current directory (cd up first, then delete)
function rmc() {
    local cwd=$(pwd)
    cd ../
    rm -rf "$cwd"
    echo "$cwd deleted"
}

# -----------------------------------------------------------------------------
# Paste.rs Utilities
# -----------------------------------------------------------------------------

# Upload to paste.rs
function paste() {
    local file=${1:-/dev/stdin}
    curl --data-binary @${file} https://paste.rs
}

# Delete from paste.rs
function dpaste() {
    local id=${1:-/dev/stdin}
    curl -X DELETE https://paste.rs/${id}
}

# Get from paste.rs
function gpaste() {
    local id=${1:-/dev/stdin}
    curl https://paste.rs/${id}
}

# -----------------------------------------------------------------------------
# Security Utilities
# -----------------------------------------------------------------------------

# Generate password using pattern (requires ~/.secure/apply_pattern.sh)
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
