#
# .zshenv
#  Set environment variables for zsh.
#

# PATH
export DOTFILES=$HOME/dotfiles
export ZDOTDIR=$DOTFILES/.zsh

# history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000             # メモリ上に保存する履歴のサイズ
export SAVEHIST=1000000            # ファイルに保存する履歴のサイズ

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
# for fzf key bindings
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80% --reverse"
