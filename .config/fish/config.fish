### Environment. {{{1
# Basic. {{{2
set -x SHELL fish
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

# GOPATH. {{{2
set -x GOPATH ~/.ghq

# Rust. {{{2
if type -q rustc
    set -x RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src >/dev/null ^&1
end

# GSR. {{{2
set -x GSR_SHOW_AHEAD 1
set -x GSR_SHOW_BEHIND 1

# PATH. {{{2
if not test -d ~/.local/bin
    mkdir -p ~/.local/bin
end

if test (count $fish_user_paths) -eq 0
    set -U fish_user_paths
    __add_fish_user_paths /usr/local/bin
    __add_fish_user_paths /usr/local/opt/coreutils/libexec/gnubin
    __add_fish_user_paths /usr/local/opt/gnu-sed/libexec/gnubin
    __add_fish_user_paths /home/linuxbrew/.linuxbrew/bin
    __add_fish_user_paths ~/.cargo/bin
    __add_fish_user_paths ~/.yarn/bin
    __add_fish_user_paths ~/.linuxbrew/bin
    __add_fish_user_paths ~/.yarn/bin
    __add_fish_user_paths ~/.config/yarn/global/node_modules/.bin
    __add_fish_user_paths ~/.local/bin
    __add_fish_user_paths ~/.local/bin/scripts
    __add_fish_user_paths ~/.ghq/src/bitbucket.org/yukimemi/scripts
    __add_fish_user_paths $GOPATH/bin
    __add_fish_user_paths $PYENV_ROOT/shims
    __add_fish_user_paths $RBENV_ROOT/shims
    echo "Update fish_user_paths"
end

# MANPATH. {{{2
set MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
set MANPATH /usr/local/opt/gnu-sed/libexec/gnuman $MANPATH

### Util functions. {{{1
function fish_right_prompt
    __fnm_version
    __pyenv_version
    __rbenv_version
end

### Alias. {{{1
if type -q exa
    alias ls 'exa'
end
if type -q bat
    alias cat 'bat'
end
alias cp "cp -v"
alias mv "mv -v"
alias l "ll"
alias ghc "stack ghc --"
alias ghci "stack ghci"
alias stackexec "stack exec"
alias runghc "stack runghc --"
alias runhaskell "stack runghc --"

# chrome. {{{2
alias twitter "open -na 'Google Chrome' --args '--app=https://mobile.twitter.com'"
alias tweetdeck "open -na 'Google Chrome' --args '--app=https://tweetdeck.com'"
alias hangout "open -na open -na 'Google Chrome' --args '--app=https://hangouts.google.com/'"

### Abbr. {{{1
abbr -a fv __filter_command_nvim
abbr -a fmvim __filter_command_mvim
abbr -a ghl __filter_command_ghq
abbr -a gsrl __filter_command_gsr
abbr -a j __filter_command_z
if type -q gomi
    abbr -a r __filter_command_gomi
else
    abbr -a r __filter_command_rm
end
abbr -a rr __filter_command_rm_recurse
abbr -a c __filter_command_cd
abbr -a fr __filter_command_fresco_remove
abbr -a b bd
abbr -a e nvim
abbr -a v vim
abbr -a o open
abbr -a tree 'exa -T'

# Git. {{{2
abbr -a g 'git'
# checkout
abbr -a gco 'git checkout'
abbr -a gcot 'git checkout --theirs'
abbr -a co __filter_command_git_select_branch
# add
abbr -a a 'git add'
# commit
abbr -a gci 'git commit -v'
# branch
abbr -a gb 'git branch'
abbr -a gba 'git branch -a'
abbr -a gbd 'git branch -d'
# pull
abbr -a gp 'git pull --rebase'
# push
abbr -a gpu 'git push'
# status
abbr -a s 'git status'
# show
abbr -a gh 'git show'
# diff
abbr -a d 'git diff'
# rebase
abbr -a gr 'git rebase'
abbr -a gri 'git rebase -i'
# log
abbr -a gl 'git log'
abbr -a glo 'git log --oneline'
abbr -a gk 'git log --graph --pretty'

# vim {{{2
abbr -a mup 'nvim -c "PackUpdate"'
abbr -a mvup 'vim -c "PackUpdate"'
abbr -a dup 'nvim -c "silent! call dein#update() | q"'
abbr -a dvup 'vim -c "silent! call dein#update() | q"'

# Chrome {{{2
abbr -a chromeapp "open -na 'Google Chrome' --args '--app=https://"

# Home-file {{{2
if __isMac
    abbr -a br 'brew-file brew'
    abbr -a bre 'brew-file edit'
    abbr -a bri 'brew-file brew install'
    abbr -a brs 'brew-file brew search'
end

### Options. {{{1
# Use fish_vi_key_bindings.
set -g fish_key_bindings fish_vi_key_bindings

### Install. {{{1
# __cli_install ghq motemen/ghq
# __cli_install gomi b4b4r07/gomi
# __cli_install jvgrep mattn/jvgrep

### Install plugin manager. {{{1
# fresco.
if not test -f ~/.cache/fresco/__fresco_install.fish
    # mkdir -p ~/.cache/fresco >/dev/null ^&1
    # curl -sfL https://raw.githubusercontent.com/masa0x80/fresco/master/install -o ~/.cache/fresco/__fresco_install.fish
    # cat ~/.cache/fresco/__fresco_install.fish | fish
    # exec fish -l
end

# fisherman.
if not type -q fisher
    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
end

### Plugin settings. {{{1
# pure {{{2
set pure_symbol_prompt "→ "
set pure_color_green (set_color "white")

# fish-global-abbreviation. {{{2
# https://qiita.com/ryotako/items/83812c2a703b965a02d9
set -U gabbr_config ~/.config/fish/.gabbr.config

# Load functions. {{{1
type -q __done_enter
