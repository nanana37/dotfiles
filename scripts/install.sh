#!/bin/bash

echo "Installing dotfiles..."

### apt ###
sudo apt update
sudo apt install stow

# Stow dotfiles
./scripts/stow.sh

# Install dependencies
echo "Installing dependencies..."

### brew ###
brew install npm zip git
# Below should be downloaded through brew for me, due to the version.
# brew install llvm@17
brew install fzf tmux zsh neovim ripgrep

# Other CLI tools
brew install bat eza powerlevel10k lazygit

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Set sh
chsh -s $(which zsh)

echo "Installation complete."
