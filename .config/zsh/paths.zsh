# =============================================================================
# PATH Configuration
# =============================================================================
# Environment paths for development tools and utilities

# User binaries
export PATH="$HOME/.local/bin:$PATH"

# Project directories
export PATH="/opt/projects:$PATH"

# User-installed language tools
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"

# Platform-specific paths
if [ "$IS_MAC" = true ]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
    export PATH="/opt/homebrew/opt/node/bin:$PATH"
fi

if [ "$IS_LINUX" = true ] || [ "$IS_WSL" = true ]; then
    export PATH="$HOME/zig-linux-x86_64-0.14.0-dev.43+96501d338:$PATH"
    export PATH="/home/tlambert/.opencode/bin:$PATH"
fi

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Haskell (ghcup)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
