{ config, pkgs, lib, ... }:

let
  fromTOML = builtins.fromTOML or (builtins.importTOML); # Fallback if needed, though fromTOML should be there
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # Defaults
      s = "source";
      sz = "source ~/.zshrc";
      zshconfig = "vi ~/dotfiles/modules/shell.nix"; # Redirect to this file
      vimconfig = "vi ~/.config/nvim/init.lua";
      tmuxconfig = "vi ~/.tmux.conf";
      zc = "zshconfig";
      vc = "vimconfig";
      tc = "tmuxconfig";
      dof = "cd $DOTFILES";

      # LS replacements
      ls = "eza";
      ll = "eza -l";
      la = "eza -a";
      lal = "eza -al";
      tree = "eza --tree";

      # Git
      g = "lazygit";
      gs = "git status";
      gd = "git diff";
      ga = "git add";
      grs = "git restore";
      grt = "git restore --staged";
      gc = "git commit";
      gp = "git push";
      gpl = "git pull";

      # Utils
      vi = "nvim";
      vim = "nvim";
      cl = "clear";
      hh = "history";
      tm = "tmux";
      tml = "tmux ls";
      tma = "tmux a";
      
      # FZF Custom
      c = "fzf_cd";
      v = "fzf_vi";
    };

    initContent = ''
      # Zsh Options
      setopt inc_append_history
      setopt share_history
      setopt auto_cd
      setopt no_flow_control
      
      # Vi Mode
      bindkey -v
      
      # Custom Functions
      fancy-ctrl-z() {
        if [[ $#BUFFER -eq 0 ]]; then
          BUFFER="fg"
          zle accept-line
        else
          zle push-input
          zle clear-screen
        fi
      }
      zle -N fancy-ctrl-z
      
      fzf_cd() {
        local dir
        dir=$(find ''${1:-.} -path '*/\.*' -prune \
                        -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
      }
      
      fzf_vi() {
        fzf --preview 'bat --style=numbers --color=always {}' | xargs nvim
      }
      
      # Bindings
      bindkey -M viins '^R' fzf-history-widget
    '';

    plugins = [
      # {
      #   name = "zsh-nix-shell";
      #   file = "nix-shell.plugin.zsh";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "chisui";
      #     repo = "zsh-nix-shell";
      #     rev = "v0.5.0";
      #     sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
      #   };
      # }
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Load settings from the existing TOML file
    settings = builtins.fromTOML (builtins.readFile ../packages/starship/.config/starship.toml);
  };

  # Dependencies needed for the shell config
  home.packages = with pkgs; [
    fzf
    eza
    bat
    zoxide
    ripgrep
    fd
  ];
}
