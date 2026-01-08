{ config, pkgs, ... }:

{
  # Minimal Home Manager config - only manages packages needed for shell
  # All dotfiles are managed by stow

  home.stateVersion = "24.05";

  # CLI tools installed via Nix
  home.packages = with pkgs; [
    stow
    fzf
    eza
    bat
    zoxide
    ripgrep
    fd
    lazygit
  ];

  programs.home-manager.enable = true;

  # Suppress warnings
  manual.manpages.enable = false;
  manual.html.enable = false;
  manual.json.enable = false;
}
