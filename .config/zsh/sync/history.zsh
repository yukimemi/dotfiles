# =============================================================================
# File        : history.zsh
# Author      : yukimemi
# Last Change : 2023/09/07 23:12:16.
# =============================================================================

if [[ -d ~/Syncthing ]]; then
  export HISTFILE=~/Syncthing/pc/.zsh_history
else
  export HISTFILE=~/.zsh_history
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

