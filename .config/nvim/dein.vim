" =============================================================================
" File        : dein.vim
" Author      : yukimemi
" Last Change : 2021/08/15 20:11:07.
" =============================================================================

" Plugin:
" Use dein.
let s:dein_dir = expand('$CACHE_HOME/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute 'silent! !git clone --depth 1 https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
endif
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

let g:dein#auto_recache = v:true
let g:dein#lazy_rplugins = v:true
let g:dein#install_log_filename = '~/.dein_install.log'
let g:dein#enable_notification = v:true
let g:dein#install_progress_type = 'none'
let g:dein#install_github_api_token = $DEIN_GITHUB_API_TOKEN

function! IsInstalled(name) abort
  silent! return !dein#check_install(a:name)
endfunction

if !dein#load_state(s:dein_dir)
  if has('clientserver')
    call dein#call_hook('source')
  endif
  finish
endif

let s:toml_file = $VIM_PATH . '/dein.toml'

call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
call dein#load_toml(s:toml_file)
call dein#end()
if has('clientserver')
  call dein#call_hook('source')
endif
call dein#save_state()

" Check and install.
if !v:vim_did_enter && dein#check_install()
  call dein#install()
endif

if !empty(map(dein#check_clean(), 'delete(v:val, "rf")'))
  call dein#recache_runtimepath()
endif
