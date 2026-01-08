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
      "homebrew/services"
    ];

    # Brews
    brews = [
      "mas" # Mac App Store CLI
    ];

    # Casks
    casks = [
      # "firefox"
      # "google-chrome"
      # "visual-studio-code"
    ];
    
    # Mac App Store Apps
    masApps = {};
  };
}
