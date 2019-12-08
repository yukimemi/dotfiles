" =============================================================================
" File        : dein.vim
" Author      : yukimemi
" Last Change : 2019/02/10 03:02:23.
" =============================================================================

" Plugin: {{{1
" Use dein.
let s:dein_dir = expand('$CACHE_HOME/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
endif
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

let g:dein#install_max_processes = 16
let g:dein#enable_notification = 1
let g:dein#types#git#clone_depth = 1

if !dein#load_state(s:dein_dir)
  finish
endif

let s:toml_file = $VIM_PATH . '/dein.toml'
let s:toml_all_file = $VIM_PATH . '/dein_all.toml'

call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
call dein#load_toml(s:toml_file)
" call dein#load_toml(s:toml_all_file)
call dein#end()
call dein#save_state()

" Check and install.
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
