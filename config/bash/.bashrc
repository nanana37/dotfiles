#
# ~/.bashrc
#

# ~~~~~~ Environment Variables ~~~~~~

export VISUAL=nvim
export EDITOR=nvim

# ~~~~~~ History ~~~~~~~

# TODO
# export HISTFILE=~/.histfile

# ~~~~~~ Aliases ~~~~~~

alias v=nvim
alias t='tmux'
alias e='exit'

# cd
alias ..='cd ..'
alias dot='cd ~/dotfiles'

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'

# git
alias gp='git pull'
alias gs='git status'
alias g='lazygit'

# fzf
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias vf='v $(fp)'

# ~~~~~~ Path ~~~~~~

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(starship init bash)"
