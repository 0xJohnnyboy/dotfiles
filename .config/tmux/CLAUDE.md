# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a tmux configuration directory containing:
- **tmux.conf**: Main configuration file with custom key bindings and plugin setup
- **plugins/**: Directory containing tmux plugins managed by TPM (Tmux Plugin Manager)
- **resurrect/**: Session persistence data from tmux-resurrect plugin

## Key Components

### Main Configuration (tmux.conf)
- Uses `Ctrl+Space` as prefix key instead of default `Ctrl+b`
- Configures session resurrection and continuum features
- Sets up powerline for enhanced status bar
- Enables pane content capture for session restoration

### Plugin Architecture
Uses TPM to manage these plugins:
- **tmux-sensible**: Sensible default configurations
- **tmux-powerline**: Enhanced status line with powerline styling  
- **tmux-resurrect**: Manual session save/restore functionality
- **tmux-continuum**: Automatic session saving and restoration

### Session Persistence
- Sessions are automatically saved to `resurrect/` directory
- Pane contents are captured and stored in compressed format
- Neovim sessions are integrated with resurrection strategy
- Automatic restoration is enabled on tmux startup

## Common Operations

### Plugin Management
```bash
# Install new plugins (after adding to tmux.conf)
<prefix> + I

# Update plugins  
<prefix> + U

# Remove plugins (after removing from tmux.conf)
<prefix> + alt + u
```

### Session Management
```bash
# Manually save session
<prefix> + Ctrl-s

# Manually restore session  
<prefix> + Ctrl-r
```

### Configuration Reload
```bash
# Reload tmux configuration
tmux source-file ~/.config/tmux/tmux.conf
```

## File Locations

- Main config: `~/.config/tmux/tmux.conf`
- Plugin directory: `~/.config/tmux/plugins/`
- Session data: `~/.config/tmux/resurrect/`
- TPM location: `~/.config/tmux/plugins/tpm/`