# Dotfiles Testing Guide

This document provides comprehensive testing procedures for the dotfiles installation system across all supported platforms.

## Overview

The testing strategy covers:
1. **Automated validation** - Syntax checks, dry runs (completed ✅)
2. **Manual testing** - Fresh system installations (to be performed)
3. **Regression testing** - Existing system upgrades

## Automated Validation ✅

### 1. Ansible Playbook Syntax Check
```bash
cd ~/.config/ansible
ansible-playbook --syntax-check playbook.yml
```
**Status**: ✅ Passed

### 2. Role Structure Validation
```bash
cd ~/.config/ansible
for role in prerequisites git neovim shell tmux terminal cli_tools docker languages macos_tools dotfiles; do
  echo "=== $role ==="
  [ -f roles/$role/tasks/main.yml ] && echo "✓ tasks/main.yml exists" || echo "✗ missing"
done
```
**Status**: ✅ All roles have main.yml

### 3. Install Script Validation
```bash
bash ~/install.sh --help
bash ~/install.sh --dry-run
```
**Status**: ✅ Working correctly

## Manual Testing Checklist

### Test Environment Matrix

| Platform | Version | Status | Tester | Date |
|----------|---------|--------|--------|------|
| macOS | Sonoma 14.x | ⏳ Pending | - | - |
| macOS | Ventura 13.x | ⏳ Pending | - | - |
| Ubuntu | 22.04 LTS | ⏳ Pending | - | - |
| Ubuntu | 24.04 LTS | ⏳ Pending | - | - |
| Debian | 12 (Bookworm) | ⏳ Pending | - | - |
| WSL2 | Ubuntu 22.04 | ⏳ Pending | - | - |
| WSL2 | Ubuntu 24.04 | ⏳ Pending | - | - |

### Test Case 1: Fresh macOS Installation

**Prerequisites**:
- Clean macOS VM or fresh machine
- Internet connection
- No prior dotfiles installed

**Steps**:
1. Open Terminal
2. Run one-line installer:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/0xJohnnyboy/dotfiles/main/install.sh | bash
   ```
3. Wait for installation to complete
4. Restart terminal or run `source ~/.zshrc`

**Verification Checklist**:
- [ ] Git installed (check: `git --version`)
- [ ] Neovim installed (check: `nvim --version`)
- [ ] tmux installed (check: `tmux -V`)
- [ ] WezTerm installed (check Applications folder)
- [ ] Starship prompt active (visible in terminal)
- [ ] Oh My Zsh installed (check `~/.oh-my-zsh/`)
- [ ] Homebrew installed (check: `brew --version`)
- [ ] Aerospace installed (check: `aerospace --version`)
- [ ] Ice Bar installed (check Applications folder)
- [ ] JetBrainsMono Nerd Font installed (check Font Book)
- [ ] CLI tools working:
  - [ ] `rg --version` (ripgrep)
  - [ ] `fzf --version`
  - [ ] `fd --version`
  - [ ] `bat --version`
  - [ ] `eza --version`
  - [ ] `delta --version`
  - [ ] `lazygit --version`
  - [ ] `gh --version`
- [ ] Dotfiles repository cloned to `~/.dotfiles`
- [ ] `dotfiles` alias working (check: `dotfiles status`)
- [ ] Neovim config present (`~/.config/nvim/init.lua`)
- [ ] Neovim plugins auto-installing on first launch
- [ ] tmux config present (`~/.config/tmux/tmux.conf`)
- [ ] TPM installed (`~/.config/tmux/plugins/tpm/`)
- [ ] WezTerm config present (`~/.config/wezterm/wezterm.lua`)
- [ ] macOS Dock preferences applied:
  - [ ] Dock on left side
  - [ ] Dock autohide enabled
  - [ ] Magnification enabled
  - [ ] No recent apps in Dock

**Expected Duration**: 15-30 minutes

**Issues Found**: (Record any issues here)

---

### Test Case 2: Fresh Ubuntu/Debian Installation

**Prerequisites**:
- Clean Ubuntu/Debian VM or fresh machine
- Internet connection
- sudo access

**Steps**:
1. Open terminal
2. Update package lists: `sudo apt update`
3. Run one-line installer:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/0xJohnnyboy/dotfiles/main/install.sh | bash
   ```
4. Wait for installation to complete
5. Restart terminal or run `source ~/.zshrc`

**Verification Checklist**:
- [ ] Git built from source (check: `git --version` shows 2.47.0)
- [ ] Neovim built from source (check: `nvim --version` shows 0.10.2)
- [ ] tmux installed (check: `tmux -V`)
- [ ] WezTerm installed (AppImage in Applications)
- [ ] Starship prompt active (visible in terminal)
- [ ] Oh My Zsh installed (check `~/.oh-my-zsh/`)
- [ ] Build dependencies installed (gcc, make, cmake, etc.)
- [ ] CLI tools working:
  - [ ] `rg --version` (ripgrep)
  - [ ] `fzf --version`
  - [ ] `fd --version`
  - [ ] `bat --version`
  - [ ] `eza --version`
  - [ ] `delta --version`
  - [ ] `lazygit --version`
  - [ ] `gh --version`
- [ ] Docker installed (check: `docker --version`)
- [ ] User added to docker group (check: `groups`)
- [ ] Go installed (check: `go version`)
- [ ] Node.js installed via nvm (check: `node --version`)
- [ ] Rust installed via rustup (check: `rustc --version`)
- [ ] Dotfiles repository cloned to `~/.dotfiles`
- [ ] `dotfiles` alias working (check: `dotfiles status`)
- [ ] Neovim config present and working
- [ ] Neovim plugins auto-installing on first launch
- [ ] tmux config present and working
- [ ] TPM installed and plugins working
- [ ] WezTerm config present

**Expected Duration**: 30-45 minutes (includes building from source)

**Issues Found**: (Record any issues here)

---

### Test Case 3: Fresh WSL2 Installation

**Prerequisites**:
- WSL2 enabled on Windows
- Fresh Ubuntu on WSL2
- Internet connection

**Steps**:
1. Open WSL terminal
2. Update package lists: `sudo apt update`
3. Run one-line installer:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/0xJohnnyboy/dotfiles/main/install.sh | bash
   ```
4. Wait for installation to complete
5. Restart terminal or run `source ~/.zshrc`

**Verification Checklist**:
- [ ] WSL detected correctly (install script shows "WSL detected")
- [ ] Git built from source (check: `git --version`)
- [ ] Neovim built from source (check: `nvim --version`)
- [ ] tmux installed and working
- [ ] Starship prompt active
- [ ] Oh My Zsh installed
- [ ] CLI tools working (all listed in Ubuntu test)
- [ ] Docker skipped or Docker Desktop integration noted
- [ ] Go, Node, Rust installed
- [ ] Dotfiles repository cloned
- [ ] `dotfiles` alias working
- [ ] Neovim config working with WSL-specific settings
- [ ] WezTerm config has WSL-specific settings (if using WezTerm)
- [ ] No macOS-specific tools attempted (aerospace, ice bar)

**Expected Duration**: 30-45 minutes

**Issues Found**: (Record any issues here)

---

### Test Case 4: Minimal Installation

**Platform**: Any (macOS, Linux, WSL)

**Steps**:
```bash
curl -fsSL https://raw.githubusercontent.com/0xJohnnyboy/dotfiles/main/install.sh | bash -s -- --minimal
```

**Verification Checklist**:
- [ ] Shell tools installed (zsh, oh-my-zsh, starship)
- [ ] Basic CLI tools installed (rg, fzf, fd, bat, eza)
- [ ] Dotfiles cloned and applied
- [ ] Git installed (from package manager, not built)
- [ ] Neovim NOT built from source (skipped or from package manager)
- [ ] Docker NOT installed
- [ ] Languages NOT installed (Go, Node, Rust)
- [ ] Installation completed faster than full install

**Expected Duration**: 5-10 minutes

**Issues Found**: (Record any issues here)

---

### Test Case 5: Selective Installation (Tags)

**Platform**: Any

**Steps**:
```bash
# Install only Neovim and Git
bash ~/install.sh --tags neovim,git
```

**Verification Checklist**:
- [ ] Only selected components installed
- [ ] Git built from source (version 2.47.0)
- [ ] Neovim built from source (version 0.10.2)
- [ ] Other components NOT installed (shell, tmux, docker, etc.)
- [ ] Installation completed quickly

**Expected Duration**: 10-15 minutes

**Common Tag Combinations to Test**:
- [ ] `--tags neovim,git,shell` - Developer essentials
- [ ] `--tags cli` - CLI tools only
- [ ] `--tags docker,languages` - Development environment
- [ ] `--tags macos` - macOS tools (on macOS only)

**Issues Found**: (Record any issues here)

---

### Test Case 6: Idempotency Test

**Platform**: Any (after successful full installation)

**Steps**:
1. Run full installation
2. Verify everything works
3. Run installation again:
   ```bash
   bash ~/install.sh
   ```
4. Verify no errors and nothing breaks

**Verification Checklist**:
- [ ] Script completes without errors
- [ ] No duplicate installations
- [ ] Existing configs not overwritten
- [ ] All tools still working after second run
- [ ] Git repository not re-cloned (existing one used)
- [ ] Ansible reports "ok" or "changed" appropriately
- [ ] No disk space wasted on duplicates

**Expected Behavior**: Should see mostly "ok" status, few "changed", no failures

**Expected Duration**: 5-10 minutes

**Issues Found**: (Record any issues here)

---

### Test Case 7: Existing Setup Upgrade

**Platform**: Any (existing dotfiles installation)

**Prerequisites**:
- Existing dotfiles from previous version
- User has made local customizations

**Steps**:
1. Backup current setup:
   ```bash
   cp -r ~/.config ~/.config.backup.$(date +%Y%m%d)
   ```
2. Commit or stash local changes:
   ```bash
   dotfiles status
   dotfiles stash
   ```
3. Pull latest changes:
   ```bash
   dotfiles pull
   ```
4. Run installer:
   ```bash
   bash ~/install.sh
   ```
5. Restore local customizations if needed

**Verification Checklist**:
- [ ] Backup created successfully
- [ ] Pull completed without conflicts (or conflicts resolved)
- [ ] New Ansible roles installed
- [ ] Existing configs preserved
- [ ] Local customizations retained (or can be restored)
- [ ] All new features working (Dock prefs, etc.)
- [ ] No data loss
- [ ] User can continue working normally

**Expected Duration**: 10-20 minutes

**Issues Found**: (Record any issues here)

---

## Dry-Run Testing ✅

Before any actual installation, test dry-run mode:

```bash
bash ~/install.sh --dry-run
```

**Verification**:
- [ ] Shows detected OS correctly
- [ ] Lists what would be installed
- [ ] Shows Ansible check mode output
- [ ] Makes NO actual changes to system
- [ ] Exits cleanly

**Status**: ✅ Completed successfully

---

## Common Issues and Troubleshooting

### Issue: Ansible fails with "module not found"
**Solution**: Ensure Ansible is installed: `pip3 install ansible`

### Issue: Git clone fails with permission denied
**Solution**:
1. Check SSH key is added to GitHub: `ssh -T git@github.com`
2. Or use HTTPS URL in install.sh temporarily

### Issue: Neovim build fails
**Solution**:
1. Check build dependencies installed
2. Look for specific error in build output
3. Try package manager install instead: `--minimal` flag

### Issue: Docker permission denied on Linux
**Solution**:
1. User needs to log out and back in for docker group to take effect
2. Or run: `newgrp docker`

### Issue: macOS Dock preferences not applying
**Solution**:
1. Log out and back in to macOS
2. Or manually restart Dock: `killall Dock`

### Issue: tmux plugins not loading
**Solution**:
1. Open tmux: `tmux`
2. Install TPM plugins: `<prefix> + I` (Ctrl+Space then Shift+I)

### Issue: Neovim plugins not installing
**Solution**:
1. Launch nvim
2. Wait for lazy.nvim to auto-bootstrap
3. Or manually trigger: `:Lazy sync`

---

## Performance Benchmarks

Expected installation times:

| Platform | Full Install | Minimal Install | Tags (selective) |
|----------|-------------|-----------------|------------------|
| macOS (brew) | 15-30 min | 5-10 min | 10-15 min |
| Ubuntu (build) | 30-45 min | 10-15 min | 15-25 min |
| WSL2 (build) | 30-45 min | 10-15 min | 15-25 min |

Factors affecting time:
- Internet speed (downloading packages)
- CPU cores (building from source)
- Existing cached packages

---

## Test Result Summary

### Automated Tests
- [x] Ansible syntax validation
- [x] Role structure validation
- [x] Install script help output
- [x] Dry-run mode testing

### Manual Tests (To Be Performed)
- [ ] Fresh macOS installation
- [ ] Fresh Ubuntu installation
- [ ] Fresh WSL2 installation
- [ ] Minimal installation
- [ ] Selective installation (tags)
- [ ] Idempotency test
- [ ] Existing setup upgrade

---

## Testing Sign-Off

Once all manual tests are completed:

**Tester**: _________________
**Date**: _________________
**Platforms Tested**: _________________
**Overall Status**: ⏳ Pending / ✅ Passed / ❌ Failed

**Critical Issues**: (None / List below)

**Recommendations**: (Optional improvements noted during testing)

---

## Next Steps After Testing

1. ✅ Fix any critical issues found
2. ✅ Update documentation based on testing feedback
3. ✅ Add discovered edge cases to this testing guide
4. ✅ Update PROJECT_PLAN.md with testing status
5. ✅ Consider adding CI/CD for automated testing
6. ✅ Tag stable release version

---

## Continuous Testing

For ongoing development:

**Before each commit**:
```bash
cd ~/.config/ansible
ansible-playbook --syntax-check playbook.yml
bash ~/install.sh --dry-run
```

**Before each release**:
- Run full test suite on all platforms
- Update this document with new test cases
- Document any breaking changes
- Update version numbers

**Recommended Testing Schedule**:
- Weekly: Dry-run validation
- Monthly: Full installation on one platform
- Per release: Full test matrix on all platforms
