#!/bin/bash
#
# GNU Stow is a symlink farm manager
# https://www.gnu.org/software/stow/manual/stow.html
#

# Get argument
action="$1"

if [ "$action" == "--help" ]; then
  echo "Usage: $0 [--unstow]"
  exit 0
fi

# Prepare the directory structure
mkdir -p "$HOME"/.config

# Define packages to ignore on Linux
IGNORE_ON_LINUX="aerospace karabiner"

OS="$(uname -s)"
echo "Detected OS: $OS"

# Stow the dotfiles
PACKDIR=packages
for package in $(ls $PACKDIR); do
  # Check if package should be skipped
  if [ "$OS" = "Linux" ]; then
    if [[ " $IGNORE_ON_LINUX " =~ " $package " ]]; then
      echo "Skipping $package on Linux..."
      continue
    fi
  fi

  if [ "$action" == "--unstow" ]; then
    stow -D -v -d "$PACKDIR" -t "$HOME" "$package"
  else
    stow -R -v -d "$PACKDIR" -t "$HOME" "$package"
  fi
done
