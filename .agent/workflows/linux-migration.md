---
description: Migrate a Linux server from legacy stow-based dotfiles to Nix home-manager
---

# Linux Migration Workflow

This workflow migrates an existing server with stow-deployed dotfiles to the new Nix-based setup.

## Prerequisites
- SSH access to the target server
- The old dotfiles are in `~/dotfiles` (stow-based setup)

## Steps

### 1. Unstow existing dotfiles
First, remove the existing symlinks created by stow:

```bash
cd ~/dotfiles
./scripts/stow.sh --unstow
```

This removes all symlinks pointing to `~/dotfiles/packages/*` from your home directory.

### 2. Install Nix (Determinate Systems installer)
// turbo
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

After installation, start a new shell or source the Nix profile:
```bash
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

### 3. Pull the latest dotfiles
```bash
cd ~/dotfiles
git fetch origin
git checkout feature/nix-migration  # or main after merging
git pull
```

### 4. Apply Home Manager configuration
// turbo
```bash
nix run home-manager/master -- switch --flake ".#linux" --impure
```

This will:
- Install all packages defined in `modules/shell.nix` (fzf, eza, bat, ripgrep, fd, zoxide)
- Configure Zsh with aliases, vi mode, and custom functions
- Configure Starship prompt with Catppuccin theme
- Configure Tmux with your keybindings and plugins

### 5. Restart your shell
```bash
exec zsh
```

## Verification
```bash
# Check starship is working
starship --version

# Check zsh aliases
alias | grep ls

# Check tmux config is applied
tmux list-keys | grep prefix
```

## Notes
- Karabiner and Aerospace are macOS-only and not included in the Linux config
- TPM (Tmux Plugin Manager) is managed natively by Nix, no need to install separately
- If you need to revert, the old stow setup still works: `./scripts/stow.sh`
