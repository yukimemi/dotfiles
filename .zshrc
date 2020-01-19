# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2020/01/19 10:41:26.
# =============================================================================

#
# Use zplugin. {{{1
#
[ ! -d ~/.zplugin ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
source ~/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

#
# plugin list. {{{2
#
zplugin ice wait'0' lucid blockf
zplugin light zsh-users/zsh-completions

zplugin ice wait'0' lucid atload'_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait'0' lucid atinit'zpcompinit; zpcdreplay'
zplugin light zdharma/fast-syntax-highlighting

zplugin light zsh-users/zsh-history-substring-search
# zplugin light rupa/z
zplugin light agkozak/zsh-z

zplugin ice from"gh-r" as"program"
zplugin load junegunn/fzf-bin

zplugin ice wait '0' lucid as'program' make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src'zhook.zsh'
zplugin light direnv/direnv

# zplugin ice wait '0' lucid as'program' pick'bin/anyenv' atclone'bin/anyenv init; echo ''eval "$(bin/anyenv init -)" > zhook.zsh''' atpull'!git reset --hard; %atclone' src'zhook.zsh'
# zplugin light anyenv/anyenv

#
# for git. {{{2
#
zplugin ice wait'1' lucid as'program' pick'bin/git-dsf'
zplugin light zdharma/zsh-diff-so-fancy
zplugin ice wait'1' lucid as'program' pick'$ZPFX/bin/git-now' make'prefix=$ZPFX install'
zplugin light iwata/git-now
zplugin ice wait'1' lucid as'program' pick'$ZPFX/bin/git-alias' make'PREFIX=$ZPFX' nocompile
zplugin light tj/git-extras
zplugin ice wait'1' lucid as'program' atclone'perl Makefile.PL PREFIX=$ZPFX' atpull'%atclone' \
            make'install' pick'$ZPFX/bin/git-cal'
zplugin light k4rthik/git-cal

#
# theme. {{{1
#
# Load the pure theme, with zsh-async library that's bundled with it
# zplugin ice pick'async.zsh' src'pure.zsh'
# zplugin light sindresorhus/pure

# Load OMZ Git library
# zplugin snippet OMZ::lib/git.zsh

# Load Git plugin from OMZ
# zplugin snippet OMZ::plugins/git/git.plugin.zsh
# zplugin cdclear -q # <- forget completions provided up to this moment

# setopt promptsubst

# Load theme from OMZ
# zplugin snippet OMZ::themes/sorin.zsh-theme

#
# functions. {{{1
#
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select

# Filter function. {{{2
function __filter_execute() {
  $__FILTER_TOOL | while read line
  do
    echo "Exec: [$@ $line]"
    $@ $line
  done
}

function __filter_select() {
  $__FILTER_TOOL | while read line
  do
    print -z $line
  done
}

# Filter history. {{{2
function __filter_history() {
  BUFFER=$(history -n 1 | $__FILTER_TOOL)
  zle clear-screen
}
zle -N __filter_history

# cd and ls. {{{2
if which lsd > /dev/null 2>&1; then
  alias ls='lsd'
elif which exa > /dev/null 2>&1; then
  alias ls='exa'
else
  alias ls='ls --color=auto'
fi
function chpwd() { ls -F }

# z and filter cd. {{{2
function __filter_z_cd() {
  z -t $1 | awk '{ $1=""; print }' | __filter_execute cd
  # z -t $1 | tac | awk '{ $1=""; print }' | __filter_execute cd
}

# kill. {{{2
function __filter_kill() {
  line=$(ps -ef | $__FILTER_TOOL)
  echo "Kill: [$line]"
  kill -9 $(echo $line | awk '{ print $2 }')
}
zle -N __filter_kill

# Shell snippets. {{{2
function shell-snippets() {
    BUFFER=$(grep -v "^#" ~/.shell-snippets | $__FILTER_TOOL)
    zle clear-screen
}
zle -N shell-snippets

# ghq list and change dir. {{{2
function ghq-list-cd() {
  local selected_dir=$(ghq list --full-path | $__FILTER_TOOL)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N ghq-list-cd

# zsh vi key command line stack - Qiita {{{2
# http://qiita.com/items/1f2c7793944b1f6cc346
function show-buffer-stack() {
  POSTDISPLAY="
  stack: $BUFFER"
  zle push-line-or-edit
}
zle -N show-buffer-stack
setopt noflowcontrol

# show option for zsh. {{{2
# http://qiita.com/mollifier/items/26c67347734f9fcda274
function showoptions() {
  set -o | sed -e 's/^no\(.*\)on$/\1  off/' -e 's/^no\(.*\)off$/\1  on/'
}

# reboot wifi. {{{2
function rebootwifi() {
  networksetup -setairportpower en0 off
  sleep 5
  networksetup -setairportpower en0 on
  networksetup -setdhcp Wi-Fi
}

#
# aliases. {{{1
#
# local alias. {{{2
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
alias l='ll'
alias e='nvim'
alias v='vim'
alias b='cd ..'
alias c='files -d | __filter_execute cd'
alias g='git'
alias s='git status --short --branch'
alias d='git diff'
alias a='git add'
alias j=__filter_z_cd
alias o='open'

alias dup='nvim -c "silent! call dein#update() | Capture Dein log"'
alias vdup='vim -c "silent! call dein#update() | Capture Dein log"'
alias mup='nvim -c "PackUpdate"'
alias vmup='vim -c "PackUpdate"'

if (which bat > /dev/null); then
  alias cat='bat'
fi

# brew. {{{2
alias br='brew-file brew'
alias bre='brew-file edit'
alias bri='brew-file brew install'
alias brs='brew-file brew search'

# Git. {{{3
if which hub > /dev/null 2>&1; then
  eval "$(hub alias -s)"
fi
# checkout
alias gco='git checkout'
alias gcot='git checkout --theirs'
# add
alias ga='git add'
# commit
alias gci='git commit -v'
# branch
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
# pull
alias gp='git pull --rebase'
# push
alias gpu='git push'
# status
alias gs='git status'
# show
alias gh='git show'
# diff
alias gd='git diff'
# rebase
alias gr='git rebase'
alias gri='git rebase -i'
# log
alias gl='git log'
alias glo='git log --oneline'
alias glp='git log -p'
alias gk='git log --graph --pretty'


# Haskell stack. {{{3
alias ghc="stack ghc --"
alias ghci="stack ghci"

# Chrome apps. {{{3
alias twitter="open -na 'Google Chrome' --args '--app=https://mobile.twitter.com'"
alias tweetdeck="open -na 'Google Chrome' --args '--app=https://tweetdeck.com'"
alias hangout="open -na 'Google Chrome' --args '--app=https://hangouts.google.com/'"
alias misskey="open -na 'Google Chrome' --args '--app=https://misskey.dev'"


# Filter aliases. {{{3
# alias ghl='ghq list -p | __filter_execute cd'
alias gsr='gsr --ahead --behind'
alias ghl='gsr --all | __filter_execute cd'
alias gsrl='gsr | __filter_execute cd'
alias gho='ghq list -p | __filter_execute gh-open'
alias r='ls -a | __filter_execute gomi'
alias fe='files -A | __filter_execute nvim'
alias fv='files -A | __filter_execute vim'

# global alias. {{{2
alias -g L=' | less'
alias -g G=' | grep'
alias -g F=' | $__FILTER_TOOL'

# abbrev-alias -g L="| less"
# abbrev-alias -g G="| grep"
# abbrev-alias -g F="| $__FILTER_TOOL"

#
# history. {{{1
#
if [ -d ~/GoogleDrive ]; then
  HISTFILE=~/GoogleDrive/.zsh_history
else
  HISTFILE=~/.zsh_history
fi
HISTSIZE=9999999
SAVEHIST=9999999

setopt sharehistory
setopt appendhistory
setopt histignorealldups
setopt histignoredups
setopt histsavenodups
setopt extendedhistory
setopt histignorespace
setopt histverify
unsetopt bgnice


#
# key bindings. {{{1
#
bindkey -v

bindkey '^Q' show-buffer-stack
# bindkey '^S' shell-snippets
bindkey '^s' pet-select

bindkey '^R' __filter_history
bindkey '^K' __filter_kill

# histry-substring-search. {{{2
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# autosuggestions. {{{2
bindkey '^F' autosuggest-accept

# move at hjkl on menu select. {{{2
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

#
# setopt. {{{1
#
setopt magicequalsubst
setopt printeightbit
setopt completeinword

#
# zstyle. {{{1
#
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''

#
# anyenv. {{{1
#
eval "$(anyenv init -)"

#
# starship. {{{1
#
if (which starship > /dev/null) ;then
  eval "$(starship init zsh)"
fi

#
# compile zshrc. {{{1
#
# if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  # zcompile ~/.zshrc
# fi

# if (which zprof > /dev/null) ;then
  # zprof | less
# fi

# vim:fdm=marker expandtab fdc=3 ft=zsh:


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
