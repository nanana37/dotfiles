#!/bin/bash
set -e

echo "Installing dotfiles..."

# Check for legacy .dotfiles (migration safeguard)
if [ -e "$HOME/.dotfiles" ] && [ "$(pwd)" != "$HOME/.dotfiles" ]; then
    echo "⚠️  Detected '$HOME/.dotfiles'."
    echo "If you are migrating from the old structure, please ensure you have 'unstowed' the old links first."
    echo "Existing symlinks pointing to ~/.dotfiles will cause conflicts."
    read -p "Have you resolved potential conflicts? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting installation."
        exit 1
    fi
fi

OS="$(uname -s)"
echo "Detected OS: $OS"

# Install Nix if not present
if ! command -v nix &> /dev/null; then
  echo "Nix not found. Installing..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  
  # Source Nix for this session
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

echo "Using Nix..."

# Install packages via nix profile (cross-platform)
nix profile install \
  nixpkgs#stow \
  nixpkgs#git \
  nixpkgs#zsh \
  nixpkgs#tmux \
  nixpkgs#neovim \
  nixpkgs#ripgrep \
  nixpkgs#fzf \
  nixpkgs#bat \
  nixpkgs#eza \
  nixpkgs#lazygit \
  nixpkgs#htop \
  nixpkgs#delta \
  nixpkgs#starship \
  nixpkgs#zoxide

# macOS specific (GUI apps via Homebrew)
if [ "$OS" = "Darwin" ]; then
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  
  echo "Installing macOS GUI apps..."
  brew install --cask karabiner-elements nikitabobko/tap/aerospace ghostty
fi

# Generate settings
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/generate-aerospace-config.sh"

# Stow dotfiles
"$SCRIPT_DIR/stow.sh"

# tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Set zsh as default shell
ZSH_PATH="$(which zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "Setting zsh as default shell..."
  if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
  fi
  chsh -s "$ZSH_PATH"
fi

echo "Installation complete."
