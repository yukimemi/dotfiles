" =============================================================================
" File        : minpac.vim
" Author      : yukimemi
" Last Change : 2020/01/11 21:59:29.
" =============================================================================

" Plugin:
" Use minpac. {{{1
set packpath^=$CACHE_HOME
let s:package_home = $CACHE_HOME . '/pack/minpac'
let s:minpac_dir = s:package_home . '/opt/minpac'
let s:plugpac_dir = $CACHE_HOME . '/plugpac'
let s:minpac_download = 0
if has('vim_starting')
  if !isdirectory(expand(s:minpac_dir))
    echo "Install minpac ..."
    execute 'silent !git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
    execute 'silent !git clone --depth 1 https://github.com/yukimemi/plugpac.vim ' . s:plugpac_dir . '/autoload'
    let s:minpac_download = 1
  endif
  execute 'set runtimepath^=' . fnamemodify(s:plugpac_dir, ':p')
  let g:plugpac_cfg_path = '~/.vim/rc'
endif

" Plugin list. {{{1
call plugpac#begin()
source $VIM_PATH/start.vim
source $VIM_PATH/opt.vim
source $VIM_PATH/lazy.vim
call plugpac#end()

" Install on initiall setup.
if s:minpac_download
  PackInstall
endif
