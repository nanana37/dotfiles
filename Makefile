# Makefile for Nix Darwin + Stow

FLAKE_URI := .#macos

.PHONY: all switch stow unstow check clean

all: switch stow

# Deploy Nix configuration (installs apps via Homebrew)
switch:
	darwin-rebuild switch --flake $(FLAKE_URI) --impure

# Link dotfiles with stow
stow:
	./scripts/generate-aerospace-config.sh
	./scripts/stow.sh

# Unlink dotfiles
unstow:
	./scripts/stow.sh --unstow

# Check the flake for errors
check:
	nix flake check

# Garbage collect old generations
clean:
	nix-collect-garbage -d
