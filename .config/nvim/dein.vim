" =============================================================================
" File        : dein.vim
" Author      : yukimemi
" Last Change : 2021/05/22 21:23:06.
" =============================================================================

" Plugin:
" Use dein.
let s:dein_dir = expand('$CACHE_HOME/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute 'silent! !git clone --depth 1 https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
endif
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

let g:dein#install_github_api_token = $DEIN_GITHUB_API_TOKEN

function! IsInstalled(name) abort
  silent! return !dein#check_install(a:name)
endfunction

" dein commands.
" https://github.com/thinca/config/blob/master/dotfiles/dot.vim/dein.vim#L20-L38
function s:update_cmpl(lead, line, pos) abort
  return filter(keys(dein#get()), 'v:val =~# "^" . a:lead')
endfunction
function s:source_cmpl(lead, line, pos) abort
  return keys(filter(dein#get(), 'v:key =~# "^" . a:lead && !v:val.sourced'))
endfunction
function s:call_with_non_empty(func, list) abort
  call call(a:func, empty(a:list) ? [] : [a:list])
endfunction
command! -nargs=* -complete=customlist,s:update_cmpl -bang DeinUpdate
      \   call s:call_with_non_empty(
      \     (<bang>0 && !empty([<f-args>])) ||
      \     get(g:, 'dein#install_github_api_token', '') is# '' ?
      \     'dein#update' : funcref('dein#check_update', [v:true]), [<f-args>])
command! -nargs=+ -complete=customlist,s:update_cmpl DeinReinstall
      \   call dein#reinstall([<f-args>])
command! -nargs=* -complete=customlist,s:source_cmpl DeinSource
      \   call s:call_with_non_empty('dein#source', [<f-args>])
command! DeinRecache call dein#recache_runtimepath()

if !dein#load_state(s:dein_dir)
  " if has('clientserver')
  "   call dein#call_hook('source')
  " endif
  finish
endif

let s:toml_file = $VIM_PATH . '/dein.toml'

call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
call dein#load_toml(s:toml_file)
call dein#end()
" if has('clientserver')
"   call dein#call_hook('source')
" endif
call dein#save_state()

" Check and install.
if !v:vim_did_enter && dein#check_install()
  call dein#install()
  " call dein#check_update(v:true)
endif

if !empty(map(dein#check_clean(), 'delete(v:val, "rf")'))
  call dein#recache_runtimepath()
endif
