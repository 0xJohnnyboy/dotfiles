# Migration Guide

This guide helps existing dotfiles users upgrade to the new Ansible-based automation system.

## Overview of Changes

The dotfiles repository has been refactored with the following major changes:

### Architecture Changes
- **Single branch**: Merged `windows-wsl` into `main` with OS detection
- **Ansible automation**: Complete infrastructure-as-code setup
- **Bootstrap script**: One-command installation via `install.sh`
- **Cross-platform**: Single codebase for macOS, Linux, and WSL

### macOS Tools Changes
- ✅ **New**: aerospace (tiling window manager)
- ✅ **New**: ice bar (menu bar manager)
- ✅ **New**: Automated Dock preferences
- ❌ **Removed**: yabai (replaced by aerospace)
- ❌ **Removed**: skhd (replaced by aerospace's built-in hotkeys)
- ❌ **Removed**: sketchybar (replaced by ice bar)

### Configuration Changes
- **Dotfiles path**: Standardized to `~/.dotfiles` (was inconsistent)
- **Neovim**: Fully refactored with lazy.nvim and native LSP
- **tmux**: Updated with TPM and session persistence
- **Shell**: Enhanced with OS detection and conditional plugins

---

## Pre-Migration Checklist

Before starting migration:

- [ ] **Backup your current setup**
  ```bash
  # Backup .config directory
  cp -r ~/.config ~/.config.backup.$(date +%Y%m%d_%H%M%S)

  # Backup home configs
  cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
  cp ~/.gitconfig ~/.gitconfig.backup.$(date +%Y%m%d_%H%M%S)
  ```

- [ ] **Document your local customizations**
  ```bash
  # List uncommitted changes
  dotfiles status
  dotfiles diff > ~/dotfiles-local-changes.diff
  ```

- [ ] **Note your current branch**
  ```bash
  dotfiles branch --show-current
  ```

- [ ] **Save list of installed packages** (macOS)
  ```bash
  brew list > ~/brew-packages-before-migration.txt
  brew list --cask > ~/brew-casks-before-migration.txt
  ```

---

## Migration Paths

Choose the migration path that fits your situation:

### Path 1: Clean Migration (Recommended)

**For**: Users comfortable starting fresh with automated setup

**Advantages**:
- Cleanest result
- All tools at correct versions
- No conflicts or legacy configs
- Fastest migration

**Steps**:

1. **Stash or commit local changes**
   ```bash
   # Option A: Commit your changes
   dotfiles add -u
   dotfiles commit -m "chore: local customizations before migration"

   # Option B: Stash your changes
   dotfiles stash push -m "Local customizations $(date +%Y%m%d)"
   ```

2. **Pull latest changes**
   ```bash
   # Fetch latest
   dotfiles fetch origin

   # Switch to main branch (if not already)
   dotfiles checkout main

   # Pull latest changes
   dotfiles pull origin main
   ```

3. **Resolve any conflicts**
   ```bash
   # If there are conflicts, check status
   dotfiles status

   # For each conflicting file, choose strategy:
   # - Keep new version: dotfiles checkout --theirs <file>
   # - Keep your version: dotfiles checkout --ours <file>
   # - Manually merge: edit the file

   # After resolving conflicts
   dotfiles add <resolved-files>
   dotfiles rebase --continue  # if in rebase
   ```

4. **Run the new install script**
   ```bash
   # Preview what will be installed
   bash ~/install.sh --dry-run

   # Full installation
   bash ~/install.sh

   # Or minimal (if you want to be selective)
   bash ~/install.sh --minimal
   ```

5. **Restore local customizations**
   ```bash
   # If you stashed changes
   dotfiles stash pop

   # Review and merge any conflicts
   # Commit your customizations
   dotfiles add -u
   dotfiles commit -m "chore: restore local customizations"
   ```

6. **Verify everything works**
   ```bash
   # Check installed versions
   git --version        # Should be 2.47.0
   nvim --version       # Should be 0.10.2
   tmux -V              # Latest from package manager

   # Check shell
   echo $SHELL          # Should be /bin/zsh or similar

   # Test nvim
   nvim                 # Should auto-install plugins

   # Test tmux
   tmux                 # Should load with config
   ```

---

### Path 2: Incremental Migration

**For**: Users who want to migrate piece by piece

**Advantages**:
- Lower risk
- Can test each component
- Easier rollback

**Steps**:

1. **Backup and pull latest**
   ```bash
   # Backup
   cp -r ~/.config ~/.config.backup.$(date +%Y%m%d)

   # Pull latest
   dotfiles pull origin main
   ```

2. **Install Ansible** (if not already installed)
   ```bash
   python3 -m pip install --user ansible
   ```

3. **Migrate components selectively**
   ```bash
   cd ~/.config/ansible

   # Start with shell (safest)
   ansible-playbook playbook.yml --tags shell --check  # Dry run
   ansible-playbook playbook.yml --tags shell

   # Then CLI tools
   ansible-playbook playbook.yml --tags cli

   # Then neovim
   ansible-playbook playbook.yml --tags neovim

   # Test after each step, continue when satisfied
   ansible-playbook playbook.yml --tags tmux
   ansible-playbook playbook.yml --tags languages
   ```

4. **Migrate macOS tools last** (if on macOS)
   ```bash
   # This will install aerospace and ice bar
   ansible-playbook playbook.yml --tags macos
   ```

5. **Verify and clean up**
   ```bash
   # Test everything works
   # Once satisfied, remove backups
   rm -rf ~/.config.backup.*
   ```

---

### Path 3: Parallel Testing

**For**: Users who want to test new setup before migrating

**Advantages**:
- Zero risk to current setup
- Can compare old vs new
- Full testing before committing

**Steps**:

1. **Create test user or VM**
   - Create new macOS user account, OR
   - Spin up Ubuntu/Debian VM, OR
   - Create fresh WSL2 instance

2. **Install fresh in test environment**
   ```bash
   curl -fsSL https://raw.githubusercontent.com/0xJohnnyboy/dotfiles/main/install.sh | bash
   ```

3. **Test thoroughly**
   - Open nvim and verify plugins load
   - Test tmux sessions
   - Test development workflow
   - Verify all keybindings work

4. **Once satisfied, migrate main account**
   Follow Path 1 (Clean Migration) on your main account

---

## macOS-Specific Migration

### Migrating from yabai/skhd/sketchybar to aerospace/ice bar

**What's changing**:
- yabai → aerospace (tiling window manager)
- skhd → aerospace hotkeys (built-in)
- sketchybar → ice bar (menu bar manager)

**Steps**:

1. **Stop old services**
   ```bash
   # Stop yabai
   yabai --stop-service
   brew services stop yabai

   # Stop skhd
   skhd --stop-service
   brew services stop skhd

   # Stop sketchybar
   brew services stop sketchybar
   ```

2. **Backup old configs** (optional, for reference)
   ```bash
   mkdir -p ~/old-wm-configs
   cp -r ~/.config/yabai ~/old-wm-configs/
   cp -r ~/.config/skhd ~/old-wm-configs/
   cp -r ~/.config/sketchybar ~/old-wm-configs/
   ```

3. **Uninstall old tools** (optional)
   ```bash
   brew uninstall yabai skhd sketchybar
   ```

4. **Install new tools**
   ```bash
   cd ~/.config/ansible
   ansible-playbook playbook.yml --tags macos
   ```

5. **Configure aerospace**
   - Configuration is at `~/.config/aerospace/aerospace.toml`
   - Already applied via dotfiles
   - Review keybindings:
     - `Cmd+1-9`: Switch to workspace 1-9
     - `Cmd+Shift+1-9`: Move window to workspace
     - `Cmd+H/J/K/L`: Focus window in direction
     - See full config in aerospace.toml

6. **Configure ice bar**
   - Launch Ice Bar from Applications
   - Click menu bar icon to configure
   - Hide unwanted menu bar items
   - Set preferences for menu bar behavior

7. **Verify Dock preferences applied**
   ```bash
   # Check Dock orientation (should be left)
   defaults read com.apple.dock orientation

   # Check autohide (should be 1)
   defaults read com.apple.dock autohide

   # If preferences didn't apply, run manually
   killall Dock
   ```

8. **Test window management**
   - Open multiple apps
   - Use `Cmd+1`, `Cmd+2` to switch workspaces
   - Use `Cmd+Shift+1` to move windows
   - Verify tiling behavior works

---

## Troubleshooting

### Issue: Conflicts during `dotfiles pull`

**Symptom**: Git shows merge conflicts

**Solution**:
```bash
# See conflicting files
dotfiles status

# For each conflict, choose strategy:
# Keep new version (recommended for refactored files)
dotfiles checkout --theirs .config/nvim/init.lua
dotfiles checkout --theirs .zshrc

# Keep your version (for files you've heavily customized)
dotfiles checkout --ours .config/custom/my-config.lua

# Manually merge (for files needing both changes)
nvim .config/file-with-conflict.lua  # Edit and resolve

# After resolving all conflicts
dotfiles add -A
dotfiles rebase --continue
```

### Issue: Ansible fails with "command not found"

**Symptom**: Ansible playbook fails with command not found errors

**Solution**:
```bash
# Ensure Ansible is installed
python3 -m pip install --user ansible

# Ensure it's in PATH
export PATH="$HOME/.local/bin:$PATH"

# Or install via brew (macOS)
brew install ansible
```

### Issue: Neovim plugins not loading

**Symptom**: Neovim opens but plugins don't work

**Solution**:
```bash
# Remove old plugin managers
rm -rf ~/.local/share/nvim/site/pack/packer
rm -rf ~/.config/nvim/plugin/packer_compiled.lua

# Launch nvim (lazy.nvim will auto-bootstrap)
nvim

# Wait for plugins to install
# Or manually trigger
:Lazy sync
```

### Issue: tmux plugins not loading

**Symptom**: tmux works but plugins/theme not loading

**Solution**:
```bash
# Ensure TPM is installed
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# In tmux, install plugins
# Press: Ctrl+Space then Shift+I

# Or run manually
~/.config/tmux/plugins/tpm/bin/install_plugins
```

### Issue: Shell aliases not working

**Symptom**: `dotfiles` alias or other aliases not found

**Solution**:
```bash
# Ensure .zshrc is sourced
source ~/.zshrc

# Check if .zshrc is symlinked correctly
ls -la ~/.zshrc

# If not, checkout from dotfiles
dotfiles checkout -- .zshrc
source ~/.zshrc
```

### Issue: aerospace not starting

**Symptom**: aerospace not managing windows after install

**Solution**:
```bash
# Check if aerospace is installed
aerospace --version

# Reload config
aerospace reload-config

# Enable start at login
# System Settings → General → Login Items → Add AeroSpace

# Check logs
tail -f ~/Library/Logs/aerospace/aerospace.log
```

### Issue: Dock preferences not applied

**Symptom**: Dock still on bottom, no autohide, etc.

**Solution**:
```bash
# Log out and back in (recommended)
# Or restart Dock manually
killall Dock

# Verify preferences are set
defaults read com.apple.dock orientation  # Should show "left"
defaults read com.apple.dock autohide     # Should show "1"

# If not, run Ansible again
cd ~/.config/ansible
ansible-playbook playbook.yml --tags macos
```

---

## Rollback Procedure

If migration fails and you need to rollback:

### Quick Rollback

```bash
# Restore from backup
rm -rf ~/.config
mv ~/.config.backup.YYYYMMDD_HHMMSS ~/.config

# Restore shell config
cp ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc

# Restart shell
exec zsh
```

### Git Rollback

```bash
# Find commit before migration
dotfiles log --oneline

# Reset to that commit (replace COMMIT_HASH)
dotfiles reset --hard COMMIT_HASH

# If you pushed, you'll need force push (careful!)
dotfiles push --force
```

### macOS Tools Rollback

```bash
# Stop new tools
brew services stop aerospace

# Reinstall old tools
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew tap FelixKratz/formulae
brew install sketchybar

# Restore old configs (if you backed them up)
cp -r ~/old-wm-configs/yabai ~/.config/
cp -r ~/old-wm-configs/skhd ~/.config/
cp -r ~/old-wm-configs/sketchybar ~/.config/

# Start old services
yabai --start-service
skhd --start-service
brew services start sketchybar
```

---

## Post-Migration Checklist

After successful migration, verify:

- [ ] **Shell**: Starship prompt displays correctly
- [ ] **Neovim**: Opens without errors, plugins loaded
- [ ] **tmux**: Status line shows, plugins active
- [ ] **Git**: `dotfiles` alias works
- [ ] **LSP**: In nvim, `:LspInfo` shows attached servers
- [ ] **Terminal**: WezTerm theme and transparency correct
- [ ] **macOS** (if applicable):
  - [ ] aerospace managing windows
  - [ ] ice bar hiding menu items
  - [ ] Dock on left with autohide
  - [ ] Workspaces switching with Cmd+1-9

**Clean up old backups** (once everything is verified):
```bash
rm -rf ~/.config.backup.*
rm ~/.zshrc.backup.*
rm ~/dotfiles-local-changes.diff
rm ~/brew-packages-before-migration.txt
rm ~/brew-casks-before-migration.txt
rm -rf ~/old-wm-configs
```

---

## Getting Help

If you encounter issues during migration:

1. **Check logs**:
   ```bash
   # Ansible logs
   cat ~/.config/ansible/ansible.log  # If logging enabled

   # Neovim logs
   nvim --headless -c 'echo stdpath("log")' -c quit

   # aerospace logs
   tail -f ~/Library/Logs/aerospace/aerospace.log
   ```

2. **Review documentation**:
   - `.config/CLAUDE.md` - Overall documentation
   - `.config/ansible/README.md` - Ansible guide
   - `.config/nvim/CLAUDE.md` - Neovim specifics
   - `.config/tmux/CLAUDE.md` - tmux specifics

3. **Report issues**:
   - GitHub Issues: https://github.com/0xJohnnyboy/dotfiles/issues
   - Include error messages and logs
   - Note your OS and version

---

## Migration Timeline Estimate

| Migration Path | Estimated Time | Risk Level |
|----------------|----------------|------------|
| Clean Migration | 30-45 minutes | Low (with backups) |
| Incremental Migration | 1-2 hours | Very Low |
| Parallel Testing | 2-4 hours | None (testing only) |

---

## What to Expect After Migration

### Improvements
- ✅ Faster installation on new machines (one command)
- ✅ Consistent setup across all platforms
- ✅ Easier to maintain and update
- ✅ Better documented
- ✅ Version-controlled automation

### Changes to Adapt To
- **macOS**: New window manager (aerospace vs yabai)
  - Slightly different keybindings
  - Learning curve for new hotkeys
  - More integrated, less scripting needed

- **Menu bar**: ice bar is simpler than sketchybar
  - Less customizable, but cleaner
  - GUI configuration instead of scripts

- **Neovim**: Lazy.nvim instead of Packer
  - Faster startup
  - Better lazy loading
  - Different plugin update workflow

### Known Limitations
- Some manual steps still required (ice bar GUI config)
- Dock preferences require logout/login to fully apply
- aerospace requires manual "enable at login" first time

---

## Success Stories

*After migration is complete, share your experience to help others!*

**Template**:
```
Platform: macOS 14 Sonoma / Ubuntu 22.04 / WSL2
Migration Path: Clean / Incremental / Parallel
Time Taken: X minutes
Issues Encountered: None / [describe]
Overall Experience: Smooth / Some bumps / Difficult
Would Recommend: Yes / No
```

---

## Appendix: Quick Reference

### Old vs New Command Reference

| Old Command | New Command |
|-------------|-------------|
| Manual git build | `ansible-playbook playbook.yml --tags git` |
| Manual nvim build | `ansible-playbook playbook.yml --tags neovim` |
| `yabai --restart-service` | `aerospace reload-config` |
| `brew services restart sketchybar` | Launch Ice Bar from Applications |
| Install.sh (macOS-specific) | `install.sh` (cross-platform) |

### File Location Changes

| Old Location | New Location |
|--------------|--------------|
| `~/.dotfiles.git` or `~/dotfiles.git` | `~/.dotfiles` (standardized) |
| `.config/macos_playbook.yml` | `.config/ansible/playbook.yml` + Darwin.yml |
| `.config/yabai/` | `.config/aerospace/` |
| `.config/sketchybar/` | (removed, use ice bar GUI) |
| `.config/skhd/` | (removed, use aerospace.toml) |

### New Features to Explore

- **install.sh flags**: `--minimal`, `--tags`, `--dry-run`, `--skip-ansible`
- **Ansible tags**: Selective installation of components
- **Testing framework**: `.config/ansible/TESTING.md`
- **Cross-platform configs**: Single codebase for all OSes
- **Automated Dock config**: No more manual `defaults write` commands
- **Persistent breakpoints**: nvim-dap breakpoints saved across sessions
