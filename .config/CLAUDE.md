# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a dotfiles configuration directory (`~/.config`) managed as part of a bare git repository using the pattern:
```bash
git --git-dir=$HOME/.dotfiles --work-tree=$HOME
```

The `dotfiles` alias in `.zshrc` provides git commands for this repository. This directory contains configurations for development tools including Neovim, tmux, WezTerm, Starship prompt, and various CLI utilities.

## Repository Structure

```
~/.config/
├── nvim/              # Neovim configuration (lazy.nvim + native LSP)
├── tmux/              # tmux configuration (TPM plugins)
├── wezterm/           # WezTerm terminal emulator config
├── git/               # Git global ignore patterns
├── starship.toml      # Starship prompt configuration
├── install.sh         # Bootstrap script for macOS setup
└── [other tools]/     # Additional tool configs (htop, neofetch, etc.)
```

## Key Configuration Files

### Neovim (`nvim/`)
- **Location**: `~/.config/nvim/`
- **Documentation**: See `nvim/CLAUDE.md` for comprehensive Neovim-specific guidance
- **Key points**:
  - Uses lazy.nvim plugin manager with 44 plugins
  - Native LSP configuration (not nvim-lspconfig)
  - LSP servers: gopls, lua_ls, typescript, angular, astro, eslint
  - Testing: neotest with gotestsum for Go
  - Debugging: nvim-dap with Delve for Go
  - Leader key: `<Space>`, LocalLeader: `,`

### tmux (`tmux/`)
- **Location**: `~/.config/tmux/`
- **Documentation**: See `tmux/CLAUDE.md` for tmux-specific guidance
- **Key points**:
  - Prefix key: `Ctrl+Space` (not default `Ctrl+b`)
  - Uses TPM (Tmux Plugin Manager) for plugin management
  - Plugins: tmux-sensible, tmux-powerline, tmux-resurrect, tmux-continuum
  - Session persistence enabled with automatic restoration
  - Vim-like pane navigation (`h`/`j`/`k`/`l`)

### WezTerm (`wezterm/wezterm.lua`)
- **Terminal emulator**: WezTerm with Lua configuration
- **Theme**: Gruvbox dark, hard (base16)
- **Transparency**: 94% opacity with blur effects (macOS/Windows)
- **Font**: JetBrainsMono NF (primary), Hack Nerd Font Mono (fallback)
- **Integration**: Transparent background matches Neovim transparency settings

### Starship Prompt (`starship.toml`)
- **Prompt framework**: Cross-shell prompt with custom format
- **Features**:
  - Username, directory, git branch/status with emoji indicators
  - Right-aligned: git state, Node.js, Lua, Docker context, memory usage
  - Memory warning threshold: 80%
  - Custom git status indicators (conflicts, ahead/behind, stashed, etc.)

### Shell Configuration (`~/.zshrc`)
- **Shell**: zsh with Oh My Zsh framework
- **Plugins**: git, asdf, vi-mode
- **Editor**: nvim (set as $EDITOR)
- **Node**: Managed via nvm
- **Key aliases**:
  - `dotfiles`: Git commands for dotfiles repo (e.g., `dotfiles status`)
  - `configure`: Edit `.zshrc` in nvim
  - `refresh`: Reload `.zshrc`
  - `l`: Enhanced ls using eza with git integration and icons
  - Git shortcuts: `ga`, `gs`, `gc`, `gco`, `gcm`, `gpl`, `gp`, `gr`, `gtr`, `gl`
  - Docker shortcuts: `dls`, `drdi`, `dsa`

## Dotfiles Management

This configuration is managed using a bare git repository pattern. **Do not use standard git commands** in `~/.config`. Instead:

```bash
# Check status of dotfiles
dotfiles status

# Add new config files
dotfiles add ~/.config/nvim/init.lua

# Commit changes
dotfiles commit -m "Update nvim config"

# Push changes
dotfiles push
```

The bare repository is located at `~/.dotfiles/` with work tree at `~` (home directory).

## Installation

### Bootstrap New System (macOS)

Run the install script:
```bash
cd ~/.config
./install.sh
```

This will install:
- Oh My Zsh
- Starship prompt
- NVM (Node Version Manager) + Node.js LTS
- Homebrew (if not present)
- Homebrew packages from `~/Brewfile` (if exists)
- JetBrains Mono Nerd Font

**Note**: Debian support is not implemented (exits with "Not supported at the moment").

### Manual Setup

If bootstrap script is not suitable:

1. **tmux plugins**:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
   # Then in tmux: <prefix> + I
   ```

2. **Neovim plugins**:
   ```bash
   nvim  # lazy.nvim auto-bootstraps and installs plugins
   ```

3. **LSP servers** (via Mason in Neovim):
   ```vim
   :Mason
   ```

4. **Nerd Font**: Install JetBrainsMono Nerd Font or Hack Nerd Font for proper icon rendering

## Common Workflows

### Editing Configurations

**Neovim**:
```bash
nvim ~/.config/nvim/init.lua
# or use the NVIM_CONFIG environment variable
nvim $NVIM_CONFIG
```

**tmux**:
```bash
nvim ~/.config/tmux/tmux.conf
# Reload after changes:
tmux source-file ~/.config/tmux/tmux.conf
```

**Shell**:
```bash
configure  # Opens ~/.zshrc in nvim
refresh    # Reloads ~/.zshrc
```

### Working with Dotfiles Repository

**Viewing changes**:
```bash
dotfiles status
dotfiles diff
```

**Committing new configs**:
```bash
dotfiles add ~/.config/tool/config.file
dotfiles commit -m "Add tool configuration"
```

**Pulling/pushing**:
```bash
dotfiles pull
dotfiles push
```

### Managing Ignored Files

Global git ignores are defined in `~/.config/git/ignore`:
- `**/.claude/settings.local.json` - Claude Code local settings

The dotfiles repository also has its own `.gitignore` at `~/.config/.gitignore` which excludes:
- Various cache directories (configstore, github-copilot, jgit, nvim_backup, etc.)
- Platform-specific files (.DS_Store)
- Application data (qBittorrent, raycast, sanity, solana, yarn)

## Development Environment

### Languages & Tools

**Go**:
- LSP: gopls (configured in `nvim/lsp/gopls.lua`)
- Testing: neotest-golang with gotestsum
- Debugging: Delve (dlv)
- Config: `~/.config/go/` (contains telemetry settings)

**JavaScript/TypeScript**:
- LSP: typescript-language-server, eslint, angular
- Runtime: Node.js via nvm
- Version: Managed per-project with nvm

**Lua**:
- LSP: lua_ls (configured in `nvim/lsp/lua_ls.lua`)
- Primary use: Neovim and WezTerm configuration

**Docker**:
- Status shown in Starship prompt when in Docker context
- Aliases for common operations (list, clean dangling images, stop all)

## Terminal Theme & Appearance

All tools are configured with a consistent theme:

- **Color scheme**: Gruvbox dark (hard variant)
- **Font**: JetBrainsMono Nerd Font (with icon support)
- **Transparency**: WezTerm background at 94% opacity
- **Status line**: tmux-powerline + Starship prompt
- **Icons**: Nerd Font icons throughout (Fern in nvim, eza in shell, Starship prompt)

Neovim explicitly disables its background to allow WezTerm transparency to show through.

## Architecture Notes

### Neovim Plugin Architecture
- Plugins auto-loaded from `lua/plugins/` directory (no manual requires)
- LSP servers configured in separate `lsp/` files and enabled via `vim.lsp.enable()`
- Uses Neovim's native LSP and completion (no external plugins)
- Transparent background maintained via autocmd in `init.lua` and `config/lazy.lua`

### tmux Plugin Architecture
- TPM manages plugins declaratively in `tmux.conf`
- Session data persists in `resurrect/` directory
- Automatic restoration on tmux startup via continuum
- Powerline configuration in separate plugin directory

### Shell Integration
- Oh My Zsh provides framework and plugin management
- Starship handles prompt rendering (replaces Oh My Zsh themes)
- vi-mode plugin enables Vim keybindings in shell
- asdf plugin provides version management (alternative to nvm for multiple runtimes)

## File Type Associations

When working with specific file types:

- **`.lua`**: Neovim config files, WezTerm config, plugin specs
- **`.conf`**: tmux configuration, neofetch configuration
- **`.toml`**: Starship prompt configuration
- **`.sh`**: Bootstrap/installation scripts
- **`.http` / `.rest`**: REST client files (Kulala plugin in nvim)
- **`.md`**: Documentation (including CLAUDE.md files)

## System Dependencies

Tools that should be installed for full functionality:

- **Core**: git, nvim, tmux, zsh
- **Shell**: oh-my-zsh, starship
- **Fonts**: JetBrainsMono Nerd Font or Hack Nerd Font
- **Node**: nvm + Node.js LTS
- **Go tooling**: gopls, dlv, gotestsum
- **Language servers**: Via Mason (`:Mason` in nvim)
- **CLI utilities**: eza (enhanced ls), ripgrep (rg), fzf (fuzzy finder)
- **Optional**: docker, helm, various language runtimes

## Platform Support

- **macOS**: Primary platform, fully supported by install.sh
- **Linux**: Configurations work but install.sh not implemented for Debian
- **Windows/WSL**: Configurations compatible, WezTerm config includes WSL backdrop support

Current environment: Linux on WSL2 (based on uname in env).
