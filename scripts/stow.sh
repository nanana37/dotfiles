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

# Stow the dotfiles
PACKDIR=packages
for package in $(ls $PACKDIR); do
  if [ "$action" == "--unstow" ]; then
    stow -D -v -d "$PACKDIR" -t "$HOME" "$package"
  else
    stow -R -v -d "$PACKDIR" -t "$HOME" "$package"
  fi
done
