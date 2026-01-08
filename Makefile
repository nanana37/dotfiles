# Makefile for Nix Darwin

# The name of the nix-darwin configuration entry point
# This matches `darwinConfigurations."macos"` in flake.nix
FLAKE_URI := .#macos

.PHONY: all switch check clean

all: switch

# Deploy the configuration to the current system
switch:
	darwin-rebuild switch --flake $(FLAKE_URI) --impure

# Check the flake for errors
check:
	nix flake check

# Garbage collect old generations
clean:
	nix-collect-garbage -d
