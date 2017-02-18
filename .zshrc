# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2017/02/18 22:59:17.
# =============================================================================

# Use zplug.
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

zplug "zplug/zplug"

zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Group dependencies
# Load "emoji-cli" if "jq" is installed in this example
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

zplug "motemen/ghq", as:command, from:gh-r
zplug "yuroyoro/git-ignore", as:command, rename-to:gi
zplug "b4b4r07/ssh-keyreg", as:command

# For OSX.
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

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
zplug load --verbose
# zplug load

# alias.
alias l='ll'
alias rm='gomi'
alias v='nvim'
alias b='cd ..'

alias dup='nvim -c "silent! call dein#update() | q"'
alias vdup='vim -c "silent! call dein#update() | q"'

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

# Check profile.
if (which zprof > /dev/null 2>&1); then
  zprof
fi

