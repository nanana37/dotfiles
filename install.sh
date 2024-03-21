#!/bin/bash

# Define variables
DOTFILES="$HOME/dotfiles"
FILES=".bashrc .bash_profile .inputrc .gitconfig .config/* .zshrc .tmux.conf"

# # Set default shell to Bash
# if [ "$(basename "$SHELL")" != "bash" ]; then
# 	chsh -s /bin/bash
# fi
# Enable nullglob shell option
# shopt -s nullglob

# Create symbolic links to new dotfiles
echo "Creating symbolic links..."
for file in $FILES; do
	ln -sfn "$DOTFILES/$file" "$HOME/${file##*/}" # Use parameter expansion to get basename
	echo "Created symlink for: $file"
done

# Install dependencies
echo "Installing dependencies..."
brew install zsh tmux

echo "Installation complete."
