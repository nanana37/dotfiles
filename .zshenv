#
# .zshenv
#  Set environment variables for zsh.
#

# PATH
export DOTFILES=$HOME/dotfiles
export ZDOTDIR=$DOTFILES/.zsh

# history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000             # size of memory
export SAVEHIST=1000000            # size of HISTFILE

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
# fzf key bindings
# Show hidden files/dirs
export FZF_TMUX=1
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'eza {} -a -h -T -F  --no-user --no-time --no-filesize --no-permissions --color=always'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
