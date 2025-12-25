#!/bin/bash
set -e

echo "Installing dotfiles..."

OS="$(uname -s)"
echo "Detected OS: $OS"

if [ "$OS" = "Linux" ]; then
  ### apt (Linux) ###
  if command -v apt &> /dev/null; then
    echo "Using apt..."
    sudo apt update
    sudo apt install -y stow git zsh tmux neovim ripgrep fzf npm zip bat eza
    # Note: Some packages might have different names on Ubuntu/Debian, e.g. fd-find instead of fd.
    # Adjusting for common names.
  else
    echo "apt not found. Please install dependencies manually."
  fi

elif [ "$OS" = "Darwin" ]; then
  ### brew (macOS) ###
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo "Using brew..."
  brew install npm zip git
  # Below should be downloaded through brew for me, due to the version.
  # brew install llvm@17
  brew install fzf tmux zsh neovim ripgrep
  
  # Other CLI tools
  brew install bat eza powerlevel10k lazygit
  
  # macOS specific
  brew install --cask karabiner-elements nikitabobko/tap/aerospace ghostty
else
  echo "Unsupported OS: $OS"
  exit 1
fi

# Stow dotfiles
./scripts/stow.sh

# tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Set shell
current_shell=$(basename "$SHELL")
if [ "$current_shell" != "zsh" ]; then
  zsh_path=$(which zsh)
  if [ -n "$zsh_path" ]; then
    echo "Changing shell to zsh..."
    chsh -s "$zsh_path"
  fi
fi

echo "Installation complete."
