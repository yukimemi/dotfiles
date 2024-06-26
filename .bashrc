shopt -s nocaseglob

alias ll='ls -l'
alias la='ls -al'

alias tmux='tmux -2'

export LANG="ja_JP.UTF-8"

if [ -e ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi


# added by travis gem
[ -f /Users/yukimemi/.travis/travis.sh ] && source /Users/yukimemi/.travis/travis.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
