shopt -s nocaseglob

alias ll='ls -l'
alias la='ls -al'

bind '"\e[A": history-search-backward'
bind '"\e[0A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[0B": history-search-forward'
bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'
