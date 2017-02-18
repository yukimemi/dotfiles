# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2017/02/19 01:06:53.
# =============================================================================

# Use zplug. {{{1
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

zplug "zplug/zplug"

# zsh-users. {{{2
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# others. {{{2
zplug "stedolan/jq", \
  from:gh-r, \
  as:command, \
  rename-to:jq
zplug "b4b4r07/emoji-cli", \
  on:"stedolan/jq"

zplug "junegunn/fzf-bin", \
  from:gh-r, \
  as:command, \
  rename-to:fzf

zplug "junegunn/fzf", \
  as:command, \
  use:bin/fzf-tmux

# zplug "jhawthorn/fzy", \
#   as:command, \
#   rename-to:fzy, \
#   hook-build:"make && sudo make install"

zplug "motemen/ghq", as:command, from:gh-r
zplug "Code-Hex/battery", as:command, from:gh-r
zplug "yuroyoro/git-ignore", as:command, rename-to:gi
zplug "b4b4r07/ssh-keyreg", as:command, use:bin
zplug "b4b4r07/zsh-vimode-visual", defer:3
# zplug "b4b4r07/ultimate", as:theme

# For OSX.
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# enhancd.
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_COMMAND="j"
export ENHANCD_HOOK_AFTER_CD="ls"

# Use prezto.
zplug "modules/git", from:prezto
zplug "modules/autosuggestions", from:prezto
zplug "modules/environment", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/spectrum", from:prezto
zplug 'modules/utility', from:prezto
zplug "modules/prompt", from:prezto

zplug "modules/osx", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"
zplug "modules/homebrew", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"

zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:prompt' theme 'sorin'
# zstyle ':prezto:module:prompt' theme 'pure'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load

# move at hjkl on menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# alias.
alias l='ll'
alias rm='gomi'
alias v='nvim'
alias b='cd ..'

alias dup='nvim -c "silent! call dein#update() | q"'
alias vdup='vim -c "silent! call dein#update() | q"'

# history {{{1
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

# zsh vi key command line stack - Qiita
# http://qiita.com/items/1f2c7793944b1f6cc346
show_buffer_stack() {
    POSTDISPLAY="
    stack: $LBUFFER"
    zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack

# global alias.
alias -g L=' | less'
alias -g G=' | grep'
alias -g P=' | fzf'

# key bindings.
# autosuggestions
bindkey '^F' autosuggest-accept

# compile zshrc.
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

