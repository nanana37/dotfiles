#
# .zshrc
# Loaded only once per session.

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/dotfiles/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# .zshrc
#

# Load OS-dependent
[ -f $ZDOTDIR/.zshrc_`uname` ] && source $ZDOTDIR/.zshrc_`uname`

# Load for local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Load private rc
[ -f $ZDOTDIR/.zshrc.private ] && source $ZDOTDIR/.zshrc.private

#################################  ALIAS  #################################
# Default
alias s='source'
alias sz='source $ZDOTDIR/.zshrc'
alias zshconfig="vi $ZDOTDIR/.zshrc"
alias vimconfig="vi $DOTFILES/.config/nvim/init.lua"
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


#################################  CONFIG  #################################
# share .zshhistory
setopt inc_append_history   # 実行時に履歴をファイルに追加
setopt share_history        # 履歴を他のシェルとリアルタイム共有する

# automatically change directory when dir name is typed
setopt auto_cd

# disable ctrl+s, ctrl+q
setopt no_flow_control

# vi mode
bindkey -v
# better vi mode
# source $HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh


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


#################################  FZF  #################################
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
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# fd - cd to selected directory
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
alias c='fcd'

# fzf with z (jump to recent directory)
fzf-z-search() {
    local res=$(z | sort -rn | cut -c 12- | fzf)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}

zle -N fzf-z-search
bindkey '^e' fzf-z-search


#################################  DEPENDENCIES  #################################
# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# p10k
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
## To customize prompt, run `p10k configure` or edit ~/dotfiles/.zsh/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

# z
[ -f $HOME/zsh-z/zsh-z.plugin.zsh ] && source $HOME/zsh-z/zsh-z.plugin.zsh
