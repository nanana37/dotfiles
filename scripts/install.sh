#!/bin/bash

echo "Installing dotfiles..."

# Stow dotfiles
sh scripts/stow.sh

# Install dependencies
echo "Installing dependencies..."

sh scripts/req_apt.sh
sh scripts/req_brew.sh

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Set sh
chsh -s $(which zsh)

echo "Installation complete."
