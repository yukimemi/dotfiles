shopt -s nocaseglob

alias ll='ls -l'
alias la='ls -al'

bind '"\e[A": history-search-backward'
bind '"\e[0A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[0B": history-search-forward'
bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'

path=(
  # Home.
  $HOME/bin
  $HOME/.local/bin
  $HOME/bin/scripts
  $HOME/local/bin
  # coreutils.
  /usr/local/opt/coreutils/libexec/gnubin
  # gnu-sed.
  /usr/local/opt/gnu-sed/libexec/gnubin
  # homebrew.
  /usr/local/bin
  # cabal.
  $HOME/.cabal/bin
  # Go.
  $GOPATH/bin
  $GOROOT/bin
  # anyenv.
  $HOME/.anyenv/bin
  # cargo.
  $HOME/.cargo/bin
  # linuxbrew
  /home/linuxbrew/.linuxbrew/bin
  # asdf.
  $HOME/.asdf/shims
)

export PATH=${PATH}:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin

export GOROOT=$(go env GOROOT)
export GOPATH=$HOME/.ghq

export PATH="$HOME/.poetry/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
