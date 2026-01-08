---
description: Setup dotfiles on a Linux server
---

# Linux Setup Workflow

Setup dotfiles on a Linux server using the legacy stow-based approach.

## Prerequisites
- SSH access to the target server
- Git installed

## Steps

### 1. Clone the repository
```bash
git clone https://github.com/nanana37/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Run the installer
// turbo
```bash
./scripts/install.sh
```

This will:
- Install packages via apt (stow, fzf, tmux, neovim, etc.)
- Install starship and zoxide
- Run stow to link dotfiles
- Set zsh as default shell

### 3. Restart your shell
```bash
exec zsh
```

## Verification
```bash
# Check starship is working
starship --version

# Check zsh aliases
alias | grep ls

# Check tmux config
tmux list-keys | grep prefix
```

## Notes
- Karabiner and Aerospace are macOS-only and skipped on Linux
- If you need to unlink: `./scripts/stow.sh --unstow`
