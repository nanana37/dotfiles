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

    # Brews
    brews = [
      "mas" # Mac App Store CLI
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
      #"tailscale" # If you want to manage tailscale via brew
    ];
    
    # Mac App Store Apps
    masApps = {};
  };
}
