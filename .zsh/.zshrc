#
# .zshrc
#

# Load OS-dependent
[ -f $ZDOTDIR/.zshrc_`uname` ] && source $ZDOTDIR/.zshrc_`uname`

#################################  ALIAS  #################################
# Default
alias s='source'
alias sz='source $ZDOTDIR/.zshrc'
alias zshconfig="vi $ZDOTDIR/.zshrc"
alias vimconfig="vi $DOTFILES/.vimrc"
alias tmuxconfig="vi $DOTFILES/.tmux.conf"
alias envconfig="vi $DOTFILES/.zshenv"
alias zc='zshconfig'
alias vc='vimconfig'
alias tc='tmuxconfig'
alias ec='envconfig'
alias dof='cd ~/dotfiles'

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lal='ls -al'
alias tree='tree -C'
alias t='tree -al'
alias grep='grep --color=auto'

alias g='lazygit'

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias grs='git restore'
alias grt='git restore --staged'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'

alias vi='nvim'
alias vim='nvim'

alias cl='clear'
alias hh='history'

alias tm='tmux'
alias tml='tmux ls'
alias tma='tmux attach -t'
alias tms='tmux new -s'

# Batcat
if [ -x "$(command -v bat)" ]; then
  alias cat='bat'
fi

# eza
if [ -x "$(command -v eza)" ]; then
  alias ls='eza'
fi

# fzf
alias vf='vim $(fzf)'

##################################  FUNCTIONS  ##################################
# C-z to fg
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
bindkey '^Z' fancy-ctrl-z

#################################  HISTORY  #################################
# share .zshhistory
setopt inc_append_history   # 実行時に履歴をファイルに追加
setopt share_history        # 履歴を他のシェルとリアルタイム共有する

#################################  COMPLEMENT  #################################
# enable completion
autoload -Uz compinit && compinit

# 補完候補をそのまま探す -> 小文字を大文字に変えて探す -> 大文字を小文字に変えて探す
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''


### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2
#################################  OTHERS  #################################
# automatically change directory when dir name is typed
setopt auto_cd

# disable ctrl+s, ctrl+q
setopt no_flow_control


#################################  DEPENDENCIES  #################################
# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship
## configuration at ~/.config/starship.toml
eval "$(starship init zsh)"
