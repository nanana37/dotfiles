# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

#
# .zshrc
# Loaded only once per session.

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
alias vimconfig="vi $HOME/.config/nvim/init.lua"
alias tmuxconfig="vi $HOME/.tmux.conf"
alias zc='zshconfig'
alias vc='vimconfig'
alias tc='tmuxconfig'
alias dof="cd $DOTFILES"

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

alias tmux='tmux -u'  # enforce UTF-8
alias tm='tmux'
alias tml='tmux ls'
alias tma='tmux a'

# Batcat
# if [ -x "$(command -v bat)" ]; then
#   alias cat='bat'
#   alias catt='/usr/bin/cat'
# fi

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
autoload -Uz compinit
setopt extendedglob
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

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
# For fzf < 0.48.0, source the key-bindings and completion files
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi
if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# fd - cd to selected directory
fzf_cd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
alias c='fzf_cd'

# fv - fuzzy open with vim
fzf_vi() {
  fzf --preview 'bat --style=numbers --color=always {}' | xargs nvim
}
alias v='fzf_vi'

# tldr
alias tld='tldr "$(tldr -l | fzf)"'

#################################  PROMPT  #################################
## Powerlevel10k ##
# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
# Uncomment both the following lines and the the first line of this file.

# [[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh
# source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

## Prompt ##
# Set SIMPLE_PROMPT=1 in ~/.zshrc.local to use minimal prompt on specific machines
if [[ -n "$SIMPLE_PROMPT" ]]; then
  # Minimal prompt with colors: green user@host, blue dir
  PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '
elif command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

#################################  DEPENDENCIES  #################################
# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# NVM Lazy Load
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm node npm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}
node() {
    unset -f nvm node npm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    node "$@"
}
npm() {
    unset -f nvm node npm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    npm "$@"
}
