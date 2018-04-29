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
function __add_fish_user_paths -a addpath
    if test -d $addpath
        set -U fish_user_paths $addpath $fish_user_paths
end
end

set -U fish_user_paths
__add_fish_user_paths /usr/local/opt/coreutils/libexec/gnubin
__add_fish_user_paths /usr/local/opt/gnu-sed/libexec/gnubin

__add_fish_user_paths ~/bin/scripts
__add_fish_user_paths $GOPATH/bin
__add_fish_user_paths ~/.cargo/bin
__add_fish_user_paths ~/.yarn/bin
__add_fish_user_paths ~/.linuxbrew/bin
__add_fish_user_paths /home/linuxbrew/.linuxbrew/bin
if type -q node
    and type -q yarn
    __add_fish_user_paths (yarn global bin)
end

if not test -d ~/.local/bin
    mkdir -p ~/.local/bin
end
__add_fish_user_paths ~/.local/bin
__add_fish_user_paths ~/.local/bin/scripts

# MANPATH. {{{2
set MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
set MANPATH /usr/local/opt/gnu-sed/libexec/gnuman $MANPATH

### Util functions. {{{1
# cd and ls. {{{2
function cd
    builtin cd $argv
    ls -a
    __save_directory $PWD &
end

# Judge OS. {{{2
function isMac
    return (test (uname) = "Darwin")
end

function isLinux
    return (test (uname) != "Darwin")
end

# Install func. {{{2
function in
    if type -q brew
        brew $argv
else if type -q apt-get
    apt-get $argv
else if type -q yum
    yum $argv
end
end

function cli_install -a cmd repo
    if not test -d ~/.local/bin
        mkdir -p ~/.local/bin
end
if not type -q $cmd
    curl -L git.io/cli | env L=$repo sh
end
end

# stack new. {{{2
function stacknew -a name
    if test (count $argv) -ne 1
        echo "Set create project name."
else
    stack new $name -p "author-email:yukimemi@gmail.com" -p "author-name:yukimemi" -p "category:Development" -p "copyright:(c) 2017, yukimemi" -p "github-username:yukimemi"
end
end


# Enter hook. {{{2
function done_enter --on-event fish_postexec
    if test -z "$argv"
        if git rev-parse --is-inside-work-tree >/dev/null ^&1
            echo (set_color yellow)"--- git status ---"(set_color normal)
            git status -sb
    end
end
end

# History share. {{{2
# https://qiita.com/yoshiori/items/f1c01dd94bb5f0489cf6
function history-merge --on-event fish_preexec
    history --save
    history --merge
end


### prompt. {{{1
# right_prompt for pwd and git.
# function fish_right_prompt
#   prompt_pwd
#   __terlar_git_prompt
# end

### Alias. {{{1
if type -q exa
    alias ls 'exa'
end
alias cp "cp -v"
alias mv "mv -v"
alias l "ll"
alias ghc "stack ghc --"
alias ghci "stack ghci"
alias stackexec "stack exec"
alias runghc "stack runghc --"
alias runhaskell "stack runghc --"

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
abbr -a vup 'vim -c "PackUpdate"'
abbr -a dup 'nvim -c "silent! call dein#update() | q"'
abbr -a dvup 'vim -c "silent! call dein#update() | q"'

### Options. {{{1
# Use fish_vi_key_bindings.
set -g fish_key_bindings fish_vi_key_bindings

### Install. {{{1
# cli_install ghq motemen/ghq
# cli_install gomi b4b4r07/gomi
# cli_install jvgrep mattn/jvgrep

### Install plugin manager. {{{1
# fresco.
if not test -f ~/.cache/fresco/__fresco_install.fish
    mkdir -p ~/.cache/fresco >/dev/null ^&1
    curl -sfL https://raw.githubusercontent.com/masa0x80/fresco/master/install -o ~/.cache/fresco/__fresco_install.fish
    cat ~/.cache/fresco/__fresco_install.fish | fish

    fresco fisherman/getopts
    fresco fisherman/z
    fresco 0rax/fish-bd
    fresco rafaelrinaldi/pure
    fresco masa0x80/replace_multiple_dots.fish
    fresco ryotako/fish-global-abbreviation
    exec fish -l
end

# fisherman.
if not type -q fisher
    # curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
end


### Plugin settings. {{{1
# pure {{{2
set pure_symbol_prompt "→ "
set pure_color_green (set_color "white")

# fish-global-abbreviation. {{{2
# https://qiita.com/ryotako/items/83812c2a703b965a02d9
set -U gabbr_config ~/.config/fish/.gabbr.config

