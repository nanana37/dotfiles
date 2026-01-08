{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    
    # Prefix
    shortcut = "space"; # C-space
    
    # Settings
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    terminal = "tmux-256color";
    
    # Plugins
    plugins = with pkgs.tmuxPlugins; [
      yank
      vim-tmux-navigator
    ];

    # Extra Config (Bindings, Status Bar, Popups)
    extraConfig = ''
      # Renumber windows on window close
      set -g renumber-windows on

      # Window & Pane Bindings
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key v split-window -h -c "#{pane_current_path}"
      bind-key s split-window -v -c "#{pane_current_path}"
      bind-key c new-window -c "#{pane_current_path}"

      bind-key x kill-pane 
      bind-key q kill-pane
      bind-key C-q kill-pane

      # Resize
      bind-key H resize-pane -L 5
      bind-key J resize-pane -D 5
      bind-key K resize-pane -U 5
      bind-key L resize-pane -R 5

      # Styles
      set -g pane-border-style fg=colour240,bg=default
      set -g pane-active-border-style fg=colour135,bg=default

      # Show list
      bind-key C-w choose-session

      # Popups (requires standard tmux command in path, ensuring compat)
      bind C-p popup -xC -yC -w90% -h90% -E -d "#{pane_current_path}" '\
        if [ popup = $(tmux display -p -F "#{session_name}") ]; then \
          tmux detach-client ; \
        else \
          tmux attach -t popup || tmux new -s popup ; \
        fi \
      '
      bind g popup -xC -yC -w95% -h95% -E -d "#{pane_current_path}" "lazygit"
      bind C-g popup -xC -yC -w95% -h95% -E -d "#{pane_current_path}" "lazygit"

      # Status Bar
      set -g status-position bottom
      set -g status-left-length 85
      set -g status-left '#[fg=white][#[fg=colour135]#S #[fg=white]on #[fg=colour135]#h#[fg=white]]'
      set -g window-status-current-format "#[fg=black,bold bg=default]│#[fg=colour135 bg=black]#W#[fg=black,bold bg=default]│"
      set -g status-style bg=default
      set -g status-right '#(date +"%a %b %d %H:%M")'
      set -g status-justify centre
    '';
  };
}
