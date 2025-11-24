# =============================================================================
# Platform-Specific Configuration
# =============================================================================
# OS-specific initialization and settings

# -----------------------------------------------------------------------------
# macOS
# -----------------------------------------------------------------------------
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
fi

# -----------------------------------------------------------------------------
# Linux / WSL
# -----------------------------------------------------------------------------
if [ "$IS_LINUX" = true ] || [ "$IS_WSL" = true ]; then
    # Add Linux-specific configuration here
    :
fi
