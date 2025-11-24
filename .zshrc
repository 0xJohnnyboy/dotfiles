# =============================================================================
# Main zsh Configuration
# =============================================================================
# Modular zsh configuration
# Individual components are loaded from ~/.config/zsh/

# Configuration directory
ZSH_CONFIG_DIR="$HOME/.config/zsh"

# =============================================================================
# Core Setup (must run before loading modules)
# =============================================================================

# OS Detection (required by other modules)
source "$ZSH_CONFIG_DIR/os-detection.zsh"

# Oh My Zsh Framework
export ZSH="$HOME/.oh-my-zsh"

# Plugins (conditional based on OS)
if [ "$IS_MAC" = true ]; then
    plugins=(git)
else
    plugins=(git asdf vi-mode)
fi

source $ZSH/oh-my-zsh.sh

# =============================================================================
# Load All Modules Automatically
# =============================================================================
# Loads all .zsh files in order, excluding:
# - os-detection.zsh (already loaded above)
# - *.local.zsh (local overrides, loaded at the end)

# Priority order for core modules
for config_file in \
    environment \
    paths \
    aliases \
    functions \
    completions \
    platform-specific; do

    if [ -f "$ZSH_CONFIG_DIR/${config_file}.zsh" ]; then
        source "$ZSH_CONFIG_DIR/${config_file}.zsh"
    fi
done

# Load any additional custom modules (not in priority list)
for config_file in "$ZSH_CONFIG_DIR"/*.zsh; do
    # Skip already loaded files and local overrides
    filename=$(basename "$config_file")
    case "$filename" in
        os-detection.zsh|environment.zsh|paths.zsh|aliases.zsh|functions.zsh|completions.zsh|platform-specific.zsh|*.local.zsh)
            continue
            ;;
        *)
            source "$config_file"
            ;;
    esac
done

# Load local overrides last (not committed to dotfiles)
setopt nullglob
for local_config in "$ZSH_CONFIG_DIR"/*.local.zsh; do
    [ -f "$local_config" ] && source "$local_config"
done
unsetopt nullglob
