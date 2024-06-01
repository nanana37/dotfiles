#!/bin/bash
#
# GNU Stow is a symlink farm manager
# https://www.gnu.org/software/stow/manual/stow.html
#

# Prepare the directory structure
mkdir -p $HOME/.config

# Stow the dotfiles
PACKDIR=packages
for package in $(ls $PACKDIR); do
	stow -R -v -d $PACKDIR -t $HOME $package
done
