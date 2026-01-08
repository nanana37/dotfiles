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
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      palette = "catppuccin_macchiato";

      character = {
        success_symbol = "[[󰄛](green) ❯](peach)";
        error_symbol = "[[󰄛](red) ❯](peach)";
        vimcmd_symbol = "[󰄛 ❮](subtext1)";
      };

      git_branch = {
        style = "bold mauve";
      };

      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };

      palettes.catppuccin_latte = {
        rosewater = "#dc8a78";
        flamingo = "#dd7878";
        pink = "#ea76cb";
        mauve = "#8839ef";
        red = "#d20f39";
        maroon = "#e64553";
        peach = "#fe640b";
        yellow = "#df8e1d";
        green = "#40a02b";
        teal = "#179299";
        sky = "#04a5e5";
        sapphire = "#209fb5";
        blue = "#1e66f5";
        lavender = "#7287fd";
        text = "#4c4f69";
        subtext1 = "#5c5f77";
        subtext0 = "#6c6f85";
        overlay2 = "#7c7f93";
        overlay1 = "#8c8fa1";
        overlay0 = "#9ca0b0";
        surface2 = "#acb0be";
        surface1 = "#bcc0cc";
        surface0 = "#ccd0da";
        base = "#eff1f5";
        mantle = "#e6e9ef";
        crust = "#dce0e8";
      };

      palettes.catppuccin_frappe = {
        rosewater = "#f2d5cf";
        flamingo = "#eebebe";
        pink = "#f4b8e4";
        mauve = "#ca9ee6";
        red = "#e78284";
        maroon = "#ea999c";
        peach = "#ef9f76";
        yellow = "#e5c890";
        green = "#a6d189";
        teal = "#81c8be";
        sky = "#99d1db";
        sapphire = "#85c1dc";
        blue = "#8caaee";
        lavender = "#babbf1";
        text = "#c6d0f5";
        subtext1 = "#b5bfe2";
        subtext0 = "#a5adce";
        overlay2 = "#949cbb";
        overlay1 = "#838ba7";
        overlay0 = "#737994";
        surface2 = "#626880";
        surface1 = "#51576d";
        surface0 = "#414559";
        base = "#303446";
        mantle = "#292c3c";
        crust = "#232634";
      };

      palettes.catppuccin_macchiato = {
        rosewater = "#f4dbd6";
        flamingo = "#f0c6c6";
        pink = "#f5bde6";
        mauve = "#c6a0f6";
        red = "#ed8796";
        maroon = "#ee99a0";
        peach = "#f5a97f";
        yellow = "#eed49f";
        green = "#a6da95";
        teal = "#8bd5ca";
        sky = "#91d7e3";
        sapphire = "#7dc4e4";
        blue = "#8aadf4";
        lavender = "#b7bdf8";
        text = "#cad3f5";
        subtext1 = "#b8c0e0";
        subtext0 = "#a5adcb";
        overlay2 = "#939ab7";
        overlay1 = "#8087a2";
        overlay0 = "#6e738d";
        surface2 = "#5b6078";
        surface1 = "#494d64";
        surface0 = "#363a4f";
        base = "#24273a";
        mantle = "#1e2030";
        crust = "#181926";
      };

      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
    };
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
