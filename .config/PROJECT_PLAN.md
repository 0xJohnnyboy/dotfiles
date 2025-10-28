# Dotfiles Refactoring Project Plan

## Executive Summary

Transform the current multi-branch dotfiles repository into a unified, cross-platform configuration management system using:
- Single `main` branch with OS detection
- Ansible for automated installation
- curl-able bootstrap script for one-command setup

## Current State Analysis

### Repository Structure
- **Location**: `~/.dotfiles` (bare git repo)
- **Branches**:
  - `main`: macOS-specific (sketchybar, yabai, skhd)
  - `windows-wsl`: WSL/Linux-specific (current working branch)
  - `windows`: Legacy
  - `nvim/lazy.nvim-migration`: Feature branch

### Key Differences Between Branches

**macOS-only (main branch)** [UPDATED]:
- `.config/aerospace/` - macOS tiling window manager (CURRENT)
- Ice Bar - macOS menu bar (no config files needed)
- ~~`.config/sketchybar/`~~ - REMOVED (obsolete)
- ~~`.config/skhd/`~~ - REMOVED (obsolete)
- ~~`.config/yabai/`~~ - REMOVED (obsolete)
- ~~`.config/macos_playbook.yml`~~ - REMOVED (obsolete)
- ~~`.config/macos_setup.sh`~~ - REMOVED (obsolete)
- Brewfile reference in .zshrc

**WSL/Linux (windows-wsl branch)**:
- Complete nvim refactoring (lazy.nvim, native LSP, 44 plugins)
- tmux configuration with TPM
- htop, neofetch configs
- Updated .zshrc (asdf, vi-mode plugins)

**Already Cross-Platform**:
- WezTerm config (has both macOS and WSL settings!)
- Starship prompt (minimal diff)
- Git config

### Issues to Resolve

1. **Dotfiles alias inconsistency**:
   - main: `$HOME/.dotfiles`
   - windows-wsl: `$HOME/dotfiles.git`
   - Actual location: `$HOME/.dotfiles`

2. **nvim completely different**: Main has old config, WSL has full rewrite

3. **Platform-specific tools not conditionally loaded**

## Target Architecture

### Directory Structure

```
~/
├── .dotfiles/                          # Bare git repository
├── .config/
│   ├── CLAUDE.md                      # Overall documentation
│   ├── nvim/                          # Neovim (unified, cross-platform)
│   │   ├── CLAUDE.md
│   │   ├── init.lua                   # OS detection included
│   │   ├── lsp/
│   │   └── lua/
│   ├── tmux/                          # tmux (unified)
│   │   ├── CLAUDE.md
│   │   └── tmux.conf
│   ├── wezterm/                       # WezTerm (already unified!)
│   │   └── wezterm.lua
│   ├── starship.toml                  # Starship (unified)
│   ├── git/                           # Git config
│   ├── aerospace/                     # macOS tiling window manager
│   │   └── aerospace.toml
│   └── ansible/                       # NEW: Ansible automation
│       ├── ansible.cfg
│       ├── playbook.yml
│       ├── inventory.ini
│       ├── requirements.yml
│       ├── group_vars/
│       │   ├── all.yml               # Common variables
│       │   ├── Darwin.yml            # macOS variables
│       │   └── Linux.yml             # Linux variables
│       └── roles/
│           ├── prerequisites/        # Build tools, compilers
│           ├── git/                  # Build git from source
│           ├── neovim/               # Build neovim from source
│           ├── shell/                # zsh, oh-my-zsh, starship
│           ├── tmux/                 # tmux + TPM + plugins
│           ├── terminal/             # WezTerm, fonts
│           ├── cli_tools/            # ripgrep, fzf, eza, fd, bat, etc.
│           ├── docker/               # Docker + docker-compose
│           ├── languages/            # Go, Node (nvm), Rust
│           ├── macos_tools/          # sketchybar, yabai, skhd (Darwin only)
│           └── dotfiles/             # Symlink/apply configs
├── install.sh                         # NEW: Bootstrap script (curl-able)
├── .zshrc                            # Shell config with OS detection
└── Brewfile                          # macOS package list

```

### OS Detection Strategy (Hybrid Approach)

#### 1. Shell Scripts (.zshrc, install.sh)
```bash
case "$(uname -s)" in
    Darwin*)
        export IS_MAC=true
        export IS_WSL=false
        export IS_LINUX=false
        ;;
    Linux*)
        if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
            export IS_WSL=true
            export IS_MAC=false
            export IS_LINUX=false
        else
            export IS_LINUX=true
            export IS_MAC=false
            export IS_WSL=false
        fi
        ;;
esac
```

#### 2. Lua Configs (Neovim, WezTerm)
```lua
-- OS Detection
local uname = vim.loop.os_uname()
local is_wsl = vim.fn.has("wsl") == 1
local is_mac = uname.sysname == "Darwin"
local is_linux = uname.sysname == "Linux" and not is_wsl

-- Apply conditional settings
if is_mac then
    -- macOS specific
elseif is_wsl then
    -- WSL specific
elseif is_linux then
    -- Native Linux
end
```

#### 3. Ansible Variables
```yaml
# group_vars/all.yml
neovim_version: "0.10.0"
git_version: "2.47.0"

# OS-specific included automatically via group_vars/Darwin.yml and group_vars/Linux.yml
```

## Implementation Plan

### Phase 1: Branch Merge & Conflict Resolution ✅ COMPLETED

**Goal**: Merge windows-wsl into main, resolving conflicts with OS detection

**Steps**:
1. ✅ Create backup branch from current windows-wsl
2. ✅ Checkout main branch
3. ✅ Merge windows-wsl into main with rebase
4. ✅ Resolve conflicts:
   - `.zshrc`: Merged both versions, fixed dotfiles alias to `.dotfiles.git`
   - `nvim/init.lua`: Kept modular version (HEAD)
   - `nvim/lazy-lock.json`: Kept current version
   - `wezterm/wezterm.lua`: Kept cross-platform version
   - `tmux/tmux.conf`: Fixed quoting
5. ✅ Remove obsolete sketchybar configs
6. ✅ Remove obsolete macos_playbook.yml and macos_setup.sh

**Files with OS Detection**:
- ✅ `.zshrc` - Already has conditional aliases, PATH, plugins
- ✅ WezTerm - Already has proper OS detection
- ✅ Neovim - Fully cross-platform (no OS detection needed)

**Actual Time**: Completed

### Phase 2: Config Refactoring ✅ COMPLETED

**Goal**: Add OS detection to configs that need it

**Tasks**:

#### 2.1 Refactor .zshrc ✅
- ✅ OS detection already at top
- ✅ Conditional Homebrew PATH (macOS only) - already implemented
- ✅ Conditional aliases - already implemented
- ✅ Dotfiles alias consistent (`.dotfiles.git`)
- ✅ Conditional plugin loading (asdf, etc.) - already implemented

#### 2.2 Clean Up WezTerm Config ✅
- ✅ Already has proper OS detection for macOS, WSL, and Linux
- ✅ Platform-specific settings (blur for macOS, acrylic for WSL)
- ✅ Platform-specific font names

#### 2.3 Review Neovim Config ✅
- ✅ LSP configs are fully cross-platform (no hardcoded paths)
- ✅ All LSP servers use simple command names in PATH
- ✅ No OS-specific code needed

#### 2.4 macOS-Specific Configs ✅
- ✅ Removed obsolete sketchybar, yabai, skhd configs
- ✅ Keeping aerospace config in `.config/aerospace/`
- ✅ Ice Bar (no config files needed)
- Note: Not creating separate macos/ directory since only aerospace config remains

**Actual Time**: Completed

### Phase 3: Ansible Infrastructure

**Goal**: Create complete Ansible automation for fresh system setup

#### 3.1 Directory Structure
```
.config/ansible/
├── ansible.cfg
├── inventory.ini
├── playbook.yml
├── requirements.yml
├── group_vars/
│   ├── all.yml
│   ├── Darwin.yml
│   └── Linux.yml
└── roles/
    ├── prerequisites/
    ├── git/
    ├── neovim/
    ├── shell/
    ├── tmux/
    ├── terminal/
    ├── cli_tools/
    ├── docker/
    ├── languages/
    ├── macos_tools/
    └── dotfiles/
```

#### 3.2 Core Roles

**prerequisites** (build tools):
- Debian: build-essential, pkg-config, cmake, autoconf, gettext, curl, wget
- macOS: Xcode CLI tools
- Tasks: Install compilers, make, etc.

**git** (build from source):
- Download git source (version from group_vars)
- Build and install to /usr/local
- Verify installation
- Tags: git, build

**neovim** (build from source):
- Install nvim build dependencies
- Clone neovim repo
- Build with CMAKE_BUILD_TYPE=RelWithDebInfo
- Install to /usr/local
- Verify installation
- Tags: neovim, build

**shell** (zsh + oh-my-zsh + starship):
- Install zsh
- Install oh-my-zsh (if not present)
- Download and install starship
- Install fonts (JetBrainsMono Nerd Font)
- Set zsh as default shell
- Tags: shell, zsh

**tmux** (tmux + TPM):
- Install tmux (from package manager)
- Clone TPM to ~/.config/tmux/plugins/tpm
- Apply tmux.conf
- Tags: tmux

**terminal** (WezTerm):
- Download WezTerm (OS-specific)
- Install WezTerm
- macOS: .app bundle
- Linux: AppImage or deb package
- WSL: Windows installer?
- Tags: terminal, wezterm

**cli_tools** (essential CLI utilities):
- ripgrep (rg)
- fzf
- fd-find
- bat
- eza
- delta (git diff)
- lazygit
- gh (GitHub CLI)
- jq, yq
- htop/btop
- ncdu, duf
- Tags: cli, tools

**docker** (Docker + compose):
- Debian: Add Docker apt repo, install
- macOS: Docker Desktop (via brew cask)
- Install docker-compose
- Add user to docker group (Linux)
- Tags: docker

**languages** (Go, Node, Rust):
- Go: Download and install from official site
- Node: Install nvm, install Node LTS
- Rust: Install rustup
- Install language servers: gopls, delve, rust-analyzer, typescript-language-server
- Tags: golang, nodejs, rust, lsp

**macos_tools** (macOS-specific):
- Install Homebrew
- Install from Brewfile
- Install aerospace (tiling window manager)
- Install ice bar (menu bar)
- Apply aerospace config from .config/aerospace/
- when: ansible_os_family == "Darwin"
- Tags: macos, wm

**dotfiles** (apply configurations):
- Ensure .dotfiles bare repo exists
- Checkout configs to home directory
- Handle conflicts (backup existing)
- Tags: dotfiles, config

#### 3.3 Variables (group_vars/all.yml)

```yaml
---
# Version pinning
git_version: "2.47.0"
neovim_version: "0.10.0"
go_version: "1.22.0"
node_lts_version: "20"

# User settings
dotfiles_repo: "git@github.com:0xJohnnyboy/dotfiles.git"
dotfiles_dir: "{{ ansible_user_dir }}/.dotfiles"

# Font settings
nerd_font_name: "JetBrainsMono"
nerd_font_version: "3.0.1"

# Feature flags
install_docker: true
install_macos_wm: true  # Only applies on macOS
install_languages: true
build_from_source: true  # If false, use package managers
```

#### 3.4 Playbook Structure

```yaml
---
- name: Setup Development Environment
  hosts: localhost
  connection: local

  vars_files:
    - group_vars/all.yml

  pre_tasks:
    - name: Detect OS
      debug:
        msg: "Running on {{ ansible_os_family }}"

  roles:
    - role: prerequisites
      tags: [prereqs, build]

    - role: git
      tags: [git]
      when: build_from_source

    - role: neovim
      tags: [neovim]

    - role: shell
      tags: [shell, zsh]

    - role: tmux
      tags: [tmux]

    - role: terminal
      tags: [terminal, wezterm]

    - role: cli_tools
      tags: [cli]

    - role: docker
      tags: [docker]
      when: install_docker

    - role: languages
      tags: [languages, dev]
      when: install_languages

    - role: macos_tools
      tags: [macos]
      when: ansible_os_family == "Darwin" and install_macos_wm

    - role: dotfiles
      tags: [dotfiles, config]
```

**Estimated Time**: 8-12 hours

### Phase 4: Bootstrap Script

**Goal**: Create curl-able install.sh that sets up everything

**Script Flow**:
```bash
#!/usr/bin/env bash
# install.sh - Bootstrap dotfiles and development environment

1. Detect OS (Darwin, Linux, WSL)
2. Install minimal prerequisites:
   - git (from package manager for bootstrap)
   - python3 + pip
   - curl, wget
3. Install Ansible (pip install ansible)
4. Clone dotfiles as bare repo to ~/.dotfiles
5. Setup dotfiles alias temporarily
6. Checkout dotfiles to home directory
7. Run Ansible playbook: ansible-playbook ~/.config/ansible/playbook.yml
8. Source ~/.zshrc to activate new shell
9. Print success message with next steps
```

**Features**:
- Idempotent (can run multiple times)
- Dry-run mode: `./install.sh --dry-run`
- Skip certain roles: `./install.sh --skip docker`
- Minimal mode: `./install.sh --minimal` (no build from source)

**Usage**:
```bash
# One-command install
curl -fsSL https://raw.githubusercontent.com/0xJohnnyboy/dotfiles/main/install.sh | bash

# Or clone and run
git clone --bare git@github.com:0xJohnnyboy/dotfiles.git ~/.dotfiles
cd ~
git --git-dir=.dotfiles --work-tree=. checkout
./install.sh
```

**Estimated Time**: 3-4 hours

### Phase 5: Documentation Updates

**Goal**: Update all documentation to reflect new architecture

**Tasks**:
1. Update main CLAUDE.md
2. Update .config/CLAUDE.md
3. Create Ansible README
4. Create migration guide (for existing users)
5. Update repository README.md

**Estimated Time**: 2-3 hours

### Phase 6: Testing

**Goal**: Verify installation works on all platforms

**Test Environments**:
1. Fresh macOS VM/machine
2. Fresh Ubuntu/Debian VM
3. Fresh WSL instance
4. Existing setup (upgrade path)

**Test Cases**:
- Full install from curl
- Selective installs (tags)
- Minimal install
- Idempotency (run twice)
- Dry-run mode

**Estimated Time**: 4-6 hours

## Total Estimated Time

- Phase 1: 1-2 hours
- Phase 2: 2-3 hours
- Phase 3: 8-12 hours
- Phase 4: 3-4 hours
- Phase 5: 2-3 hours
- Phase 6: 4-6 hours

**Total: 20-30 hours** (2.5-4 days of focused work)

## Tools to Install via Ansible

### Essential Build Tools
- gcc, g++, make, cmake
- autoconf, automake, pkg-config
- gettext, libssl-dev, zlib1g-dev

### Core Development Tools
- git (built from source)
- neovim (built from source)
- tmux
- zsh
- curl, wget

### CLI Utilities
- ripgrep (rg) - Fast grep
- fzf - Fuzzy finder
- fd - Fast find
- bat - Better cat
- eza - Better ls
- delta - Git diff tool
- lazygit - Git TUI
- gh - GitHub CLI
- jq - JSON processor
- yq - YAML processor
- htop/btop - Process monitor
- ncdu - Disk usage
- duf - Disk usage (modern)

### Terminal & Fonts
- WezTerm
- JetBrainsMono Nerd Font
- Hack Nerd Font

### Languages & Runtimes
- Go (official binary)
- Node.js (via nvm)
- Rust (via rustup)

### Language Servers
- gopls (Go)
- delve (Go debugger)
- rust-analyzer (Rust)
- typescript-language-server (JS/TS)
- lua-language-server
- pyright (Python)

### Container Tools
- docker
- docker-compose
- lazydocker (optional)
- kubectl (optional)
- helm (optional)

### macOS-Specific
- Homebrew
- aerospace (tiling window manager)
- ice bar (menu bar)
- Brewfile packages

## Success Criteria

✅ Single main branch with no platform-specific branches
✅ Configs detect OS and adapt automatically
✅ One-command install via curl
✅ Complete development environment setup automated
✅ Idempotent installation (can run multiple times safely)
✅ Works on macOS, Linux, and WSL
✅ All existing functionality preserved
✅ Documentation updated and comprehensive
✅ Tested on all target platforms

## Migration Path (For Existing Users)

1. Backup current config: `cp -r ~/.config ~/.config.backup`
2. Commit any uncommitted changes
3. Pull latest from main branch
4. Review and resolve any conflicts
5. Run `./install.sh --upgrade` (special mode for existing setups)
6. Verify everything works
7. Delete backup if satisfied

## Future Enhancements

- Add nix/home-manager support
- Add dotbot for symlinking
- Add chezmoi for templating
- Pre-commit hooks for validation
- CI/CD pipeline for testing configs
- Multiple profiles (minimal, full, server, desktop)
- Secrets management with ansible-vault
- Automatic backups before major changes
