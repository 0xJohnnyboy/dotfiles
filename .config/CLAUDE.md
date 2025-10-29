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
~/
├── install.sh                    # Bootstrap script (curl-able, cross-platform)
├── .zshrc                        # Shell config with OS detection
├── .config/
│   ├── CLAUDE.md                # This file
│   ├── PROJECT_PLAN.md          # Refactoring plan and progress
│   ├── nvim/                    # Neovim configuration (lazy.nvim + native LSP)
│   ├── tmux/                    # tmux configuration (TPM plugins)
│   ├── wezterm/                 # WezTerm terminal emulator (cross-platform)
│   ├── aerospace/               # macOS tiling window manager
│   ├── git/                     # Git global ignore patterns
│   ├── starship.toml            # Starship prompt configuration
│   ├── ansible/                 # Ansible automation (NEW!)
│   │   ├── playbook.yml
│   │   ├── group_vars/
│   │   └── roles/              # 11 roles for automated setup
│   └── [other tools]/          # Additional tool configs (htop, neofetch, etc.)
└── .dotfiles/                   # Bare git repository
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

### Quick Start (One-Command Install)

Install complete development environment on any platform:

```bash
# One-command installation (macOS, Linux, WSL)
curl -fsSL https://raw.githubusercontent.com/0xJohnnyboy/dotfiles/main/install.sh | bash
```

This automated installer:
1. Detects OS (macOS, Linux, WSL)
2. Installs prerequisites (git, python3, ansible)
3. Clones dotfiles as bare repository to `~/.dotfiles`
4. Runs Ansible playbook for complete environment setup

**What gets installed:**
- Git (built from source)
- Neovim (built from source)
- tmux + TPM (Tmux Plugin Manager)
- zsh + oh-my-zsh + Starship prompt
- WezTerm + Nerd Fonts
- CLI tools: ripgrep, fzf, fd, bat, eza, lazygit, gh, jq, htop, etc.
- Docker (Engine on Linux, Desktop on macOS)
- Go, Node.js (nvm), Rust (rustup) + Language Servers
- **macOS only**: Homebrew, aerospace, ice bar, Brewfile packages

### Advanced Installation Options

```bash
# Preview what would be installed (dry-run)
./install.sh --dry-run

# Minimal installation (shell + CLI tools only)
./install.sh --minimal

# Install specific components
./install.sh --tags neovim,tmux,docker

# Clone dotfiles only, skip Ansible
./install.sh --skip-ansible
```

For detailed Ansible options, see [ansible/README.md](ansible/README.md).

### Manual Setup (Alternative)

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

All dependencies are automatically installed via Ansible. The bootstrap script (`install.sh`) handles everything:

**Core Tools** (built from source):
- **git** (latest: 2.47.0)
- **neovim** (latest: 0.10.2)
- **tmux** + TPM (Tmux Plugin Manager)
- **zsh** + oh-my-zsh + starship prompt

**CLI Utilities**:
- ripgrep (rg), fzf, fd-find, bat, eza
- lazygit, gh (GitHub CLI), delta (git diff)
- jq, yq, htop, ncdu, duf, tree

**Terminal & Fonts**:
- WezTerm terminal emulator
- JetBrainsMono Nerd Font
- Hack Nerd Font (fallback)

**Programming Languages** (optional, via `--tags languages`):
- **Go** (1.22.5): gopls, delve
- **Node.js** (LTS via nvm): typescript-language-server, @angular/language-server
- **Rust** (stable via rustup): rust-analyzer
- **Lua**: lua-language-server

**Containers** (optional, via `--tags docker`):
- Docker (Engine on Linux, Desktop on macOS)

**macOS-Specific Tools**:
- Homebrew package manager
- **aerospace** - Tiling window manager (replaces yabai)
- **ice bar** - Menu bar manager (replaces sketchybar)
- Brewfile packages

## Platform Support

**Fully supported cross-platform:**

- ✅ **macOS** (Intel & Apple Silicon)
  - Homebrew-based installation
  - aerospace tiling window manager
  - ice bar for menu bar management

- ✅ **Linux** (Debian/Ubuntu, Fedora/RHEL)
  - apt/dnf package managers
  - Native Docker Engine
  - All development tools

- ✅ **WSL** (Windows Subsystem for Linux)
  - Detected automatically
  - Special handling for Docker (uses Windows Docker Desktop)
  - Full Linux tooling

**OS Detection:**
- Automatic detection in install.sh and .zshrc
- WezTerm config adapts to platform (blur on macOS, acrylic on WSL)
- Ansible roles use OS-specific tasks with `when` conditions
