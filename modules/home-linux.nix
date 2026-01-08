{ config, pkgs, lib, ... }:

{
  imports = [
    ./shell.nix
    ./tmux.nix 
  ];

  # home.username and home.homeDirectory are defined in flake.nix

  home.stateVersion = "24.05";

  home.packages = [
    # Add Linux-specific packages here if needed
  ];

  # Linux-specific file links (no Karabiner on Linux)
  home.file = {
    # Add Linux-specific dotfile links here
  };

  home.sessionVariables = {
    # EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  # Suppress warnings
  manual.manpages.enable = false;
  manual.html.enable = false;
  manual.json.enable = false;
}
