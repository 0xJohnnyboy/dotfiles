export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="tjkirch"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

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

plugins=(git)

source $ZSH/oh-my-zsh.sh
