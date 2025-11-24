# =============================================================================
# Shell Completions and Enhancements
# =============================================================================
# Auto-completion and shell enhancement integrations

# Starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Zoxide (smart cd)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# Angular CLI autocompletion
if command -v ng &> /dev/null; then
    source <(ng completion script)
fi

# Bun completions (macOS only)
if [ "$IS_MAC" = true ]; then
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
fi
