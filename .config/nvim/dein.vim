" =============================================================================
" File        : dein.vim
" Author      : yukimemi
" Last Change : 2020/04/19 12:27:01.
" =============================================================================

" Plugin: {{{1
" Use dein.
let s:dein_dir = expand('$CACHE_HOME/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute 'silent! !git clone --depth 1 https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
endif
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

let g:dein#auto_recache = 1
let g:dein#enable_notification = 1
let g:dein#install_max_processes = 16
let g:dein#enable_notification = 1
let g:dein#types#git#clone_depth = 1

let g:dein_use_lightline = 1
let g:dein_use_airline = 0
let g:dein_use_coc = 1
let g:dein_use_asyncomplete = 0
let g:dein_use_ctrlp = 0
let g:dein_use_clap = 0

if !dein#load_state(s:dein_dir)
  finish
endif

let s:toml_file = $VIM_PATH . '/dein.toml'

call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
call dein#load_toml(s:toml_file)
call dein#end()
call dein#save_state()

" Check and install.
if has('vim_starting') && dein#check_install() && !g:is_windows
  call dein#install()
endif

filetype plugin indent on

