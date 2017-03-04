# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2017/03/04 13:17:26.
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
# zplug "jhawthorn/fzy", as:command, rename-to:fzy, hook-build:"make && sudo make install"
export __FILTER_TOOL=fzf-tmux

# zsh plugins. {{{2
# zplug "momo-lab/zsh-abbrev-alias" # TODO: not work.
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
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
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_COMMAND="j"
export ENHANCD_HOOK_AFTER_CD="ls"

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
function __filter() {
  $__FILTER_TOOL | while read line
  do
    echo "Exec: [$@ $line]"
    $@ $line
  done
}

# cd and ls. {{{2
function chpwd() { ls -F }

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


#
# aliases. {{{1
#
# local alias. {{{2
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias l='ll'
alias e='nvim'
alias b='cd ..'
alias c='files -d | __filter cd'
alias g='git'
alias s='git status --short --branch'
alias d='git diff'
alias a='git add .'

alias rm='gomi'
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


# Filter aliases. {{{3
alias ghl='ghq list -p | __filter cd'
alias gho='ghq list -p | __filter gh-open'
alias r='ls -a | __filter gomi'
alias fv='files -A | __filter nvim'

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
setopt share_history
setopt append_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt extended_history
setopt hist_ignore_space
setopt hist_verify


#
# key bindings. {{{1
#
# bindkey -v

bindkey '^Q' show-buffer-stack
bindkey '^S' shell-snippets

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
# compile zshrc. {{{1
#
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi


# vim:fdm=marker expandtab fdc=3 ft=zsh:

