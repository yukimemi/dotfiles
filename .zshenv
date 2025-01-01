# =============================================================================
# File        : zshenv
# Author      : yukimemi
# Last Change : 2025/01/01 20:17:03.
# =============================================================================

# For time.
# zmodload zsh/zprof

# Useful functions.
function is_mac() {
  [[ "$(uname -s)" == "Darwin" ]]
}
function is_linux() {
  [[ "$(uname -s)" == "Linux" ]]
}
function is_wsl() {
  [[ "$(uname -r)" =~ "microsoft" ]]
}

# Env setting

# Basic envs.
export LANG=ja_JP.UTF-8
export LC_CTYPE="ja_JP.UTF-8"
export SHELL=zsh
export EDITOR=hitori
export VISUAL=hitori
export GIT_EDITOR=hitori
export PAGER=bat

# Unique path.
typeset -gU cdpath fpath mailpath path

# go.
export GOPATH=$HOME/.go

# deno.
export DENO_INSTALL=$HOME/.deno

# Path.
path=(
  # cargo
  $HOME/.cargo/bin(N-/)
  # deno
  $DENO_INSTALL/bin(N-/)
  # golang
  $GOPATH/bin(N-/)
  # Home.
  $HOME/.local/bin(N-/)
  $HOME/.local/bin/scripts(N-/)
  # aqua
  $HOME/.local/share/aquaproj-aqua/bin(N-/)
  # coreutils.
  /usr/local/opt/coreutils/libexec/gnubin(N-/)
  /opt/homebrew/opt/coreutils/libexec/gnubin(N-/)
  # gnu-sed.
  /usr/local/opt/gnu-sed/libexec/gnubin(N-/)
  # homebrew.
  /usr/local/bin(N-/)
  /opt/homebrew/bin(N-/)
  # Rancher desktop.
  $HOME/.rd/bin(N-/)
  # cabal.
  $HOME/.cabal/bin(N-/)
  # yarn.
  $HOME/.yarn/bin(N-/)
  # Poetry.
  $HOME/.poetry/bin(N-/)
  # tpm.
  $HOME/.tmux/plugins/tpm(N-/)
  # normal.
  /usr/bin(N-/)
  /usr/sbin(N-/)
  /bin(N-/)
  /sbin(N-/)

  $path
)

# Manpath.
manpath=(
  # user.
  $HOME/local/share/man(N-/)
  # Homebrew.
  /usr/local/opt/coreutils/libexec/gnuman(N-/)
  # system.
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)

  $manpath
)

# Fpath.
fpath=(
  /usr/local/share/zsh-completions(N-/)
  ${ASDF_DIR}/completions(N-/)
  ${HOME}/.config/zsh/completions(N-/)

  $fpath
)

# sudo path.
typeset -xT SUDO_PATH sudo_path
typeset -gU sudo_path
sudo_path=(
  {,/usr/pkg,/usr/local,/usr}/sbin(N-/)
)

# Other.
export XDG_CONFIG_HOME="${HOME}/.config"

export GSR_SHOW_AHEAD=1
export GSR_SHOW_BEHIND=1

export MOCWORD_DATA="${HOME}/.config/mocword/mocword.sqlite"

# filter tool.
(( $+commands[fzf] )) && export __FILTER_TOOL=fzf
(( $+commands[tv] )) && export __FILTER_TOOL=tv
(( $+commands[sk] )) && export __FILTER_TOOL=sk

# neovide.
export NEOVIDE_MULTIGRID=1

# fzf.
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
(( $+commands[fd] )) && export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# local conf
[ -e ~/.zshrc_private ] && source ~/.zshrc_private
[ -e ~/.zshrc_local ] && source ~/.zshrc_local

# Compile zshenv.
[ ! -f ~/.zshenv.zwc -o ~/.zshenv -nt ~/.zshenv.zwc ] && zcompile ~/.zshenv

