# =============================================================================
# PATH Configuration
# =============================================================================
# Environment paths for development tools and utilities

# User binaries
export PATH="$HOME/.local/bin:$PATH"

# Project directories
export PATH="/opt/projects:$PATH"

# Language toolchains
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"

# Development tools
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# Platform-specific paths
if [ "$IS_MAC" = true ]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
fi

if [ "$IS_LINUX" = true ] || [ "$IS_WSL" = true ]; then
    export PATH="$HOME/zig-linux-x86_64-0.14.0-dev.43+96501d338:$PATH"
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
