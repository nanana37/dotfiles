#!/bin/bash

# Define variables
dotfiles_dir="$HOME/dotfiles"
backup_dir="$HOME/dotfiles_backup"
files=".bashrc .bash_profile .inputrc .gitconfig .config/*"

# Set default shell to Bash
chsh -s /bin/bash

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Enable nullglob shell option
shopt -s nullglob

# Backup existing dotfiles
echo "Backing up existing dotfiles..."
for file in $files; do
    if [ -e "$HOME/$file" ]; then
        mv "$HOME/$file" "$backup_dir"
        echo "Backed up: $file"
    fi
done

# Create symbolic links to new dotfiles
echo "Creating symbolic links..."
for file in $files; do
    ln -sfn "$dotfiles_dir/$file" "$HOME/${file##*/}" # Use parameter expansion to get basename
    echo "Created symlink for: $file"
done

echo "Installation complete."

