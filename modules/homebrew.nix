{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Careful: this removes everything not listed here
      upgrade = true;
    };
    
    # Taps
    taps = [
      "nikitabobko/tap"
      # "homebrew/services" # Deprecated
    ];

    # Brews (CLI tools)
    brews = [
      "mas"      # Mac App Store CLI
      "tmux"
      "neovim"
      "git"
      "npm"
      "zsh"
    ];

    # Casks
    casks = [
      "ghostty"
      "firefox"
      "google-chrome"
      "visual-studio-code" 
      "slack"
      "notion"
      "1password"
      "nikitabobko/tap/aerospace" # Tiling Window Manager
      "tailscale-app"
      "karabiner-elements"
    ];
    
    # Mac App Store Apps
    masApps = {};
  };
}
