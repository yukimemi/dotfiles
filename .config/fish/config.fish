### Load my_functions. {{{1
for func in ~/.config/fish/my_functions/*.fish
  source $func
end

### Environment. {{{1
# Basic.
set -x SHELL fish
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

# GOPATH
set -x GOPATH ~/.ghq
set -x PATH $GOPATH/bin $PATH
set -x PATH ~/bin $PATH
set -x PATH ~/bin/scripts $PATH

### Util functions. {{{1
# cd and ls.
function cd
  builtin cd $argv
  ls -a
end

### prompt. {{{1
# right_prompt for pwd and git.
function fish_right_prompt
  prompt_pwd
  __terlar_git_prompt
end

### Alias. {{{1
alias ghl __filter_command_ghq

### Abbr. {{{1
abbr -a fvim __filter_command_nvim
abbr -a fmvim __filter_command_mvim
abbr -a dup 'nvim -c "silent! call dein#update() | q"'

### Options. {{{1
# Use fish_vi_key_bindings.
set -g fish_key_bindings fish_vi_key_bindings

