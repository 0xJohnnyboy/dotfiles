# Dotfiles

Personal development environment configuration managed as a bare git repository with automated setup via Ansible.

## ✨ Features

- 🔧 **One-command installation** - Full dev environment setup with a single curl command
- 🖥️ **Cross-platform** - Works on macOS, Linux, and WSL with automatic OS detection
- 📦 **Ansible automation** - Idempotent, role-based installation
- 🎯 **Selective installation** - Install only what you need via tags
- 🔒 **Version pinning** - Control exact versions of tools
- 💾 **Safe deployment** - Backs up existing configs before applying
- 🚀 **Latest tools** - Builds git and neovim from source

## 🚀 Quick Start

### One-Command Install

```bash
curl -fsSL https://raw.githubusercontent.com/0xJohnnyboy/dotfiles/main/install.sh | bash
```

This will:
1. Install git, Python, and Ansible
2. Clone this dotfiles repository
3. Run the Ansible playbook
4. Set up your complete development environment

### Manual Installation

```bash
# Clone as bare repository
git clone --bare git@github.com:0xJohnnyboy/dotfiles.git $HOME/.dotfiles

# Checkout dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout main

# Configure to hide untracked files
git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no

# Install Ansible
python3 -m pip install --user ansible

# Run the playbook
cd ~/.config/ansible
ansible-playbook playbook.yml
```

## 📦 What Gets Installed

### Core Development Tools

| Tool | Version | Source |
|------|---------|--------|
| Git | 2.47.0 | Built from source |
| Neovim | 0.10.2 | Built from source |
| tmux | Latest | Package manager |
| zsh | Latest | Package manager |
| oh-my-zsh | Latest | Install script |
| starship | Latest | Install script |

### Terminal Setup

- **WezTerm** - Modern terminal emulator with GPU acceleration
- **Gruvbox Dark** - Consistent color scheme across all tools
- **JetBrainsMono Nerd Font** - Programming font with icon support
- **Transparent backgrounds** - Neovim matches terminal transparency

### CLI Utilities

- **ripgrep (rg)** - Fast grep replacement
- **fzf** - Fuzzy finder
- **fd** - Fast find replacement
- **bat** - Cat with syntax highlighting
- **eza** - Modern ls replacement with git integration
- **git-delta** - Better git diffs
- **lazygit** - Git TUI
- **gh** - GitHub CLI
- **jq/yq** - JSON/YAML processors
- **htop** - Interactive process viewer
- **ncdu** - Disk usage analyzer

### Neovim Configuration

- **44 plugins** via lazy.nvim
- **Native LSP** (not nvim-lspconfig)
- **Language servers**: gopls, lua_ls, typescript, angular, astro, eslint
- **Testing**: neotest with gotestsum for Go
- **Debugging**: nvim-dap with Delve for Go
- **Persistent breakpoints** across sessions
- See `.config/nvim/CLAUDE.md` for details

### Shell Configuration

- **OS detection** - Adapts to macOS, Linux, and WSL
- **Conditional plugins** - asdf and vi-mode on Linux/WSL
- **Cross-platform aliases** - `update` command works everywhere
- **Git aliases** - ga, gs, gc, gco, gcm, gpl, gp, gr, gl, gtr
- **Docker aliases** - dls, drdi, dsa
- **Custom functions** - tmns (tmux sessions), pfmt (prettier), mkcd, paste.rs integration

### Programming Languages (Optional)

- **Go** 1.22.5
- **Node.js** LTS (via nvm)
- **Rust** stable (via rustup)
- **Language servers** for all

### macOS-Specific (Optional)

- **Homebrew** - Package manager
- **aerospace** - Tiling window manager
- **skhd** - Hotkey daemon
- **sketchybar** - Custom status bar

## 📁 Repository Structure

```
~/
├── .dotfiles/                      # Bare git repository
├── .config/
│   ├── CLAUDE.md                  # Comprehensive documentation
│   ├── PROJECT_PLAN.md            # Refactoring plan & architecture
│   ├── ansible/                   # Automation infrastructure
│   │   ├── README.md              # Ansible usage guide
│   │   ├── ansible.cfg            # Ansible configuration
│   │   ├── inventory.ini          # Localhost inventory
│   │   ├── playbook.yml           # Main playbook
│   │   ├── group_vars/            # Variables
│   │   │   ├── all.yml            # Common (versions, features)
│   │   │   ├── Darwin.yml         # macOS-specific
│   │   │   └── Linux.yml          # Linux/WSL-specific
│   │   └── roles/                 # Installation roles
│   │       ├── prerequisites/     # Build tools
│   │       ├── git/               # Git from source
│   │       ├── neovim/            # Neovim from source
│   │       ├── shell/             # zsh, oh-my-zsh, starship
│   │       ├── cli_tools/         # CLI utilities
│   │       └── dotfiles/          # Apply configurations
│   ├── nvim/                      # Neovim configuration
│   │   ├── CLAUDE.md              # Neovim documentation
│   │   ├── init.lua               # Entry point
│   │   ├── lsp/                   # LSP server configs
│   │   └── lua/                   # Plugin specs & config
│   ├── tmux/                      # tmux configuration
│   │   ├── CLAUDE.md              # tmux documentation
│   │   ├── tmux.conf              # Main config
│   │   └── plugins/               # TPM plugins
│   ├── wezterm/                   # WezTerm terminal
│   │   └── wezterm.lua            # Cross-platform config
│   ├── starship.toml              # Starship prompt
│   └── git/                       # Git global config
├── .zshrc                         # Shell configuration
├── install.sh                     # Bootstrap script
└── README.md                      # This file
```

## 🎯 Usage

### Managing Dotfiles

Use the `dotfiles` alias (automatically configured):

```bash
# Check status
dotfiles status

# Add new config
dotfiles add ~/.config/nvim/init.lua

# Commit changes
dotfiles commit -m "feat: update nvim config"

# Push to GitHub
dotfiles push

# Pull latest changes
dotfiles pull
```

### Ansible Workflows

```bash
# Install everything
cd ~/.config/ansible
ansible-playbook playbook.yml

# Install specific tools (via tags)
ansible-playbook playbook.yml --tags neovim
ansible-playbook playbook.yml --tags "git,cli,shell"

# Preview what would be installed
ansible-playbook playbook.yml --check

# Minimal installation (shell + cli + dotfiles only)
ansible-playbook playbook.yml --tags "shell,cli,dotfiles"
```

### Available Ansible Tags

| Tag | Description |
|-----|-------------|
| `prereqs` | Build dependencies and compilers |
| `git` | Build git from source |
| `neovim` | Build neovim from source |
| `shell` | zsh + oh-my-zsh + starship + fonts |
| `tmux` | tmux configuration |
| `terminal` | WezTerm terminal emulator |
| `cli` | CLI utilities (rg, fzf, fd, bat, etc.) |
| `docker` | Docker + docker-compose |
| `languages` | Go, Node.js, Rust |
| `golang` | Go only |
| `nodejs` | Node.js only |
| `rust` | Rust only |
| `macos` | macOS tools (aerospace, skhd, sketchybar) |
| `dotfiles` | Apply dotfiles configuration |

### Customization

#### Change Software Versions

Edit `.config/ansible/group_vars/all.yml`:

```yaml
git_version: "2.47.0"
neovim_version: "0.10.2"
go_version: "1.22.5"
node_lts_version: "20"
```

#### Toggle Features

```yaml
install_docker: true         # Install Docker
install_macos_tools: true    # Install macOS window manager
install_languages: true      # Install Go, Node, Rust
build_from_source: true      # Build vs package manager
```

#### macOS Window Manager

Edit `.config/ansible/group_vars/Darwin.yml`:

```yaml
macos_window_manager: aerospace  # aerospace, yabai, or none
```

## 🖥️ Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| macOS (Intel) | ✅ Full | Primary development platform |
| macOS (Apple Silicon) | ✅ Full | Native ARM support |
| Ubuntu/Debian | ✅ Full | apt package manager |
| WSL2 | ✅ Full | Windows Subsystem for Linux |
| Fedora/RHEL | ⚠️ Partial | Requires dnf role completion |
| Arch Linux | ⚠️ Partial | Requires pacman role completion |

## 🔧 Installation Options

### Bootstrap Script Options

```bash
# Full installation (default)
./install.sh

# Minimal installation
./install.sh --minimal

# Specific components only
./install.sh --tags neovim,git

# Dry run (preview)
./install.sh --dry-run

# Skip Ansible, just clone dotfiles
./install.sh --skip-ansible
```

## 📚 Documentation

- **[.config/CLAUDE.md](.config/CLAUDE.md)** - Complete dotfiles documentation
- **[.config/PROJECT_PLAN.md](.config/PROJECT_PLAN.md)** - Architecture & refactoring plan
- **[.config/ansible/README.md](.config/ansible/README.md)** - Ansible usage guide
- **[.config/nvim/CLAUDE.md](.config/nvim/CLAUDE.md)** - Neovim configuration docs
- **[.config/tmux/CLAUDE.md](.config/tmux/CLAUDE.md)** - tmux configuration docs

## 🛠️ Maintenance

### Update Everything

```bash
# Pull latest dotfiles
dotfiles pull

# Re-run Ansible
cd ~/.config/ansible
ansible-playbook playbook.yml
```

### Update Specific Tool

```bash
# Edit version in group_vars/all.yml
vim ~/.config/ansible/group_vars/all.yml

# Rebuild that tool
ansible-playbook playbook.yml --tags neovim
```

### Check for Updates

**macOS:**
```bash
brew update && brew outdated
```

**Linux:**
```bash
sudo apt update && apt list --upgradable
```

## 🚨 Troubleshooting

### Ansible Not Found

```bash
# Add to PATH
export PATH="$HOME/.local/bin:$PATH"

# Or reinstall
python3 -m pip install --user ansible
```

### Permission Errors

```bash
# Run with sudo prompt
ansible-playbook playbook.yml --ask-become-pass
```

### Build Failures

```bash
# Ensure build dependencies installed
ansible-playbook playbook.yml --tags prereqs

# Check with verbose output
ansible-playbook playbook.yml --tags neovim -vvv
```

### Existing Files Conflict

Existing configs are automatically backed up to `~/.dotfiles-backup/`

## 🏗️ Architecture

### Single Branch, Multi-Platform

- Uses **OS detection** in configs (no platform-specific branches)
- Shell scripts detect: macOS, Linux, WSL
- Lua configs detect: macOS, Linux, WSL
- Ansible uses `ansible_os_family` and conditional `when` clauses

### Bare Repository Method

Dotfiles are managed as a **bare git repository** at `~/.dotfiles` with work tree at `~`:

```bash
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
```

This allows versioning files in `$HOME` without making it a git repository.

### Ansible Roles

Each tool has a dedicated role with tasks for:
- Detecting if already installed
- Installing dependencies
- Building/installing the tool
- Configuring the tool
- Verifying installation

Roles are **idempotent** - safe to run multiple times.

## 🎨 Theming

All tools use a consistent **Gruvbox Dark** color scheme:

- WezTerm: `Gruvbox dark, hard (base16)`
- Neovim: `gruvbox` theme
- Terminal transparency: 94% with blur effects

Font stack:
1. **JetBrainsMono Nerd Font** (primary)
2. **Hack Nerd Font Mono** (fallback)

## 🤝 Contributing

This is a personal dotfiles repository, but feel free to:

1. Fork it for your own use
2. Open issues for bugs
3. Submit PRs for improvements
4. Share your own customizations

## 📜 License

This is free and unencumbered software released into the public domain. See [UNLICENSE](http://unlicense.org/) for details.

## 🙏 Acknowledgments

- [How to store dotfiles with git](https://engineeringwith.kalkayan.io/series/developer-experience/storing-dotfiles-with-git-this-is-the-way/)
- [Inspired by kalkayan/dotfiles](https://github.com/kalkayan/dotfiles)
- [Ansible Documentation](https://docs.ansible.com/)
- [Bare Repository Method](https://www.atlassian.com/git/tutorials/dotfiles)

## 📞 Support

For issues or questions:

1. Check the documentation in `.config/CLAUDE.md`
2. Review Ansible docs in `.config/ansible/README.md`
3. Open an issue on GitHub
4. Check existing issues for solutions

---

**Made with** ☕ **and** [Claude Code](https://claude.com/claude-code)
