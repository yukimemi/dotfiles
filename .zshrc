# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2017/05/03 00:04:02.
# =============================================================================

#
# Use zplug. {{{1
#
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# filter tools. {{{2
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
# zplug "rcmdnk/sentaku", as:command, use:"bin/*"
# zplug "jhawthorn/fzy", as:command, rename-to:fzy, hook-build:"make && sudo make install"
export __FILTER_TOOL=fzf-tmux

# zsh plugins. {{{2
# zplug "momo-lab/zsh-abbrev-alias" # TODO: not work.
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "tcnksm/docker-alias", use:zshrc
zplug "rupa/z", use:z.sh
zplug "b4b4r07/zsh-vimode-visual", defer:3
zplug "b4b4r07/emoji-cli", on:"stedolan/jq"
# zplug "b4b4r07/zsh-history", use:init.zsh, hook-build:"make && sudo make install"


# Commands. {{{2
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
zplug "motemen/ghq", as:command, from:gh-r
zplug "Code-Hex/battery", as:command, from:gh-r
zplug "yuroyoro/git-ignore", as:command, rename-to:gi
zplug "mattn/files", as:command, hook-build:"go get -u github.com/mattn/files"
zplug "mattn/jvgrep", as:command, hook-build:"go get -u github.com/mattn/jvgrep"
zplug "mattn/memo", as:command, hook-build:"go get -u github.com/mattn/memo"
zplug "atotto/clipboard", as:command, hook-build:"go get -u github.com/atotto/clipboard/cmd/gocopy && go get -u github.com/atotto/clipboard/cmd/gopaste"

zplug "b4b4r07/gomi", as:command, from:gh-r
zplug "b4b4r07/ssh-keyreg", as:command, use:bin
# zplug "b4b4r07/zsh-gomi", as:command, use:bin/gomi, on:"junegunn/fzf-bin"

# theme. {{{2
# zplug "ginfuru/ZSH-BlackRain", as:theme
# zplug "skylerlee/zeta-zsh-theme", as:theme
# zplug "tylerreckart/hyperzsh", as:theme, as:theme
# zplug "subnixr/minimal", use:minimal.zsh
# zplug "sepehr/sepshell", as:theme
# zplug "b4b4r07/ultimate", as:theme

zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme

# enhancd. {{{2
# zplug "b4b4r07/enhancd", use:init.sh
# export ENHANCD_COMMAND="j"
# export ENHANCD_HOOK_AFTER_CD="ls"

# prezto. {{{2
# zplug "modules/syntax-highlighting", from:prezto, defer:2
# zplug "modules/autosuggestions", from:prezto
# zplug "modules/history-substring-search", from:prezto
# zplug "modules/completion", from:prezto
# zplug "modules/directory", from:prezto
# zplug "modules/editor", from:prezto
# zplug "modules/rsync", from:prezto
# zplug "modules/helper", from:prezto
# zplug "modules/environment", from:prezto
# zplug "modules/git", from:prezto
# zplug "modules/tmux", from:prezto
# zplug "modules/spectrum", from:prezto
# zplug "modules/terminal", from:prezto
# zplug 'modules/utility', from:prezto
# zplug "modules/prompt", from:prezto

# zplug "modules/osx", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"
# zplug "modules/homebrew", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"

# zstyle settings. {{{2
# zstyle ':prezto:*:*' color 'yes'
# zstyle ':prezto:module:editor' key-bindings 'vi'
# zstyle ':prezto:module:prompt' theme 'sorin'
# zstyle ':prezto:module:prompt' theme 'pure'
# zstyle ':prezto:module:prompt' theme 'random'

# zstyle ':prezto:module:syntax-highlighting' highlighters \
#   'main' \
#   'brackets' \
#   'pattern' \
#   'cursor' \
#   'root'

# Check and install plugins. {{{2
# if ! zplug check --verbose; then
#   printf "Install? [y/N]: "
#   if read -q; then
#     echo; zplug install
#   fi
# fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load


#
# functions. {{{1
#
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
function chpwd() { ls -F }

# z and filter cd. {{{2
function __filter_z_cd() {
  z -lt $1 | awk '{ print $2 }' | __filter_execute cd
}

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


#
# aliases. {{{1
#
# local alias. {{{2
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
alias l='ll'
alias e='nvim'
alias b='cd ..'
alias c='files -d | __filter_execute cd'
alias g='git'
alias s='git status --short --branch'
alias d='git diff'
alias a='git add .'
alias j=__filter_z_cd
alias o='open'

alias dup='nvim -c "silent! call dein#update() | q"'
alias vdup='vim -c "silent! call dein#update() | q"'

# Git. {{{3
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
alias gk='git log --graph --pretty'


# Haskell stack. {{{3
alias ghc="stack ghc --"
alias ghci="stack ghci"


# Filter aliases. {{{3
# alias ghl='ghq list -p | __filter_execute cd'
alias ghl='gsr --all | __filter_execute cd'
alias gsrl='gsr | __filter_execute cd'
alias gho='ghq list -p | __filter_execute gh-open'
alias r='ls -a | __filter_execute gomi'
alias fv='files -A | __filter_execute nvim'

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
if [ -d ~/Dropbox ]; then
  HISTFILE=~/Dropbox/.zsh_history
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


#
# key bindings. {{{1
#
bindkey -v

bindkey '^Q' show-buffer-stack
bindkey '^S' shell-snippets

bindkey '^R' __filter_history

# zsh-history. {{{2
export ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
export ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
export ZSH_HISTORY_KEYBIND_SCREEN="^r^r"
export ZSH_HISTORY_KEYBIND_ARROW_UP="^p"
export ZSH_HISTORY_KEYBIND_ARROW_DOWN="^n"

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
# compile zshrc. {{{1
#
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi


# vim:fdm=marker expandtab fdc=3 ft=zsh:

