# =============================================================================
# Environment Variables
# =============================================================================
# Editor and development environment configuration

# Default editor
export EDITOR=nvim
export NVIM_CONFIG="$HOME/.config/nvim/init.lua"

# Tmux-powerline configuration
[ -f "$HOME/.config/tmux-powerline/config.sh" ] && source "$HOME/.config/tmux-powerline/config.sh"
