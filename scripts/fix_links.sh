#!/bin/bash
set -e

BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
echo "Creating backup directory at $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

# List of conflicting files/directories based on stow output
targets=(
  "$HOME/.aerospace.toml"
  "$HOME/.config/aerospace"
  "$HOME/.bashrc"
  "$HOME/.bash_profile"
  "$HOME/.inputrc"
  "$HOME/.config/karabiner/assets"
  "$HOME/.config/karabiner/karabiner.json"
  "$HOME/.config/kitty"
  "$HOME/.config/nvim"
  "$HOME/.config/starship.toml"
  "$HOME/.tmux.conf"
  "$HOME/.wezterm.lua"
  "$HOME/.zsh"
  "$HOME/.zshenv"
)

for target in "${targets[@]}"; do
  if [ -e "$target" ] || [ -L "$target" ]; then
    # Move the file/symlink to the backup directory
    # Using mv preserves the file content if it's a real file/directory
    echo "Backing up and removing $target"
    
    # We need to recreate the parent directory structure in backup to avoid collisions
    # e.g. .config/nvim -> backup/.config/nvim
    REL_PATH="${target#$HOME/}"
    PARENT_DIR=$(dirname "$REL_PATH")
    mkdir -p "$BACKUP_DIR/$PARENT_DIR"
    
    mv "$target" "$BACKUP_DIR/$REL_PATH"
  else
    echo "$target does not exist, skipping."
  fi
done

echo "Backup and cleanup complete. You can examine $BACKUP_DIR if needed."
