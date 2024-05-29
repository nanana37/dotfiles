#!/bin/bash
# GNU Stow is a symlink farm manager

PACKDIR=$DOTFILES/packages
CONFDIR=$HOME/.config

mkdir -p $CONFDIR
stow -R -v -d $DOTFILES -t $CONFDIR nvim

PACKAGES="zsh tmux"
stow -R -v -d $PACKDIR -t $HOME $PACKAGES

PACKAGES="bash wezterm"
stow -R -v -d $PACKDIR -t $HOME $PACKAGES
