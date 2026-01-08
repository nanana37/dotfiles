{
  description = "MacOS Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    # Handle sudo execution: prefer SUDO_USER if set, otherwise USER
    user = builtins.getEnv "USER";
    sudoUser = builtins.getEnv "SUDO_USER";
    username = if sudoUser != "" then sudoUser else user;
    configuration = { pkgs, ... }: {
      # Custom Nix configuration
      nix.enable = false; # We use the Determinate Systems installer
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      
      # Fix "Nix search path entry ... does not exist" warning
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      # Set primary user for hidden system preferences
      system.primaryUser = username;

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;

      # Define user settings so nix-darwin knows about the user
      users.users.${username} = {
        name = username;
        home = "/Users/${username}";
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        ./modules/homebrew.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = { pkgs, ... }: {
            imports = [ ./modules/home.nix ];
            home.username = username;
            home.homeDirectory = "/Users/${username}";
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macos".pkgs;
  };
}
