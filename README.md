# dotfiles

My dotfiles for macOS and Linux.

## Quick Start

### macOS (with Nix + Stow)

```bash
# 1. Install Nix (Determinate Systems installer)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Clone and setup
git clone https://github.com/nanana37/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. Install everything
make all
```

### Linux (Stow only)

```bash
git clone https://github.com/nanana37/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/install.sh
```

## What's Managed

| Component | Tool | Command |
|-----------|------|---------|
| GUI Apps (Firefox, Ghostty, etc.) | Nix + Homebrew | `make switch` |
| CLI Tools (fzf, eza, bat, etc.) | Nix | `make switch` |
| Dotfiles (zsh, tmux, nvim, etc.) | Stow | `make stow` |

## Commands

```bash
make all      # Install everything (switch + stow)
make switch   # Install apps and CLI tools via Nix
make stow     # Link dotfiles via stow
make unstow   # Unlink dotfiles
make clean    # Garbage collect old Nix generations
```

## Structure

```
dotfiles/
├── flake.nix           # Nix flake entry point
├── Makefile            # Convenience commands
├── modules/
│   ├── home.nix        # CLI tools (fzf, eza, stow, etc.)
│   └── homebrew.nix    # macOS apps (Casks, Brews)
├── packages/           # Dotfiles managed by stow
│   ├── aerospace/
│   ├── karabiner/
│   ├── nvim/
│   ├── starship/
│   ├── tmux/
│   └── zsh/
└── scripts/
    ├── install.sh      # Legacy installer (Linux)
    ├── stow.sh         # Stow wrapper
    └── generate-aerospace-config.sh
```

## Per-Machine Customization

For lightweight prompt on servers:
```bash
echo 'export SIMPLE_PROMPT=1' >> ~/.zshrc.local
```

## Aerospace Private Config

Aerospace config may contain private workspace names. To customize:

```bash
cp packages/aerospace/.config/aerospace/aerospace-local.toml.example \
   packages/aerospace/.config/aerospace/aerospace-local.toml
# Edit aerospace-local.toml with your settings
make stow  # Regenerates and links config
```
