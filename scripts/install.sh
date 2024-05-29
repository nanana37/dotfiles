#!/bin/bash

echo "Installing dotfiles..."

# Stow dotfiles
sh stow.sh

# Install dependencies
echo "Installing dependencies..."
sh brew.sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installation complete."
