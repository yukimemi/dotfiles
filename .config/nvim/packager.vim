" =============================================================================
" File        : packager.vim
" Author      : yukimemi
" Last Change : 2018/11/11 14:08:45.
" =============================================================================

" Plugin:
" Use packager. {{{1
set packpath^=$CACHE_HOME
let s:package_home = $CACHE_HOME . '/pack/packages'
let s:packager_dir = s:package_home . '/opt/vim-packager'
let s:packager_download = 0
if has('vim_starting')
  if !isdirectory(s:packager_dir)
    echo "Install vim-packager ..."
    execute '!git clone --depth 1 https://github.com/kristijanhusak/vim-packager ' . s:packager_dir
    let s:packager_download = 1
  endif
endif

" packager init. {{{1
let s:plugins = []
function! PackInit() abort
  packadd vim-packager
  call packager#init({'dir': s:package_home})
  call packager#add('kristijanhusak/vim-packager', {'type': 'opt'})

  for plugin in s:plugins
    call packager#add(plugin[0], plugin[1])
  endfor
endfunction

" packager helper function. {{{1
let s:lazy_plugs = []
function! s:packager_add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  if has_key(l:opts, 'if')
    if ! l:opts.if
      return
    endif
  endif

  let l:name = substitute(a:repo, '^.*/', '', '')

  " packadd on filetype.
  if has_key(l:opts, 'ft')
    let l:ft = type(l:opts.ft) == type([]) ? join(l:opts.ft, ',') : l:opts.ft
    exe printf('au MyAutoCmd FileType %s packadd %s', l:ft, l:name)
  endif

  " packadd on cmd.
  if has_key(l:opts, 'cmd')
    let l:cmd = type(l:opts.cmd) == type([]) ? join(l:opts.cmd, ',') : l:opts.cmd
    exe printf('au MyAutoCmd CmdUndefined %s packadd %s', l:cmd, l:name)
  endif

  " lazy load.
  if has_key(l:opts, 'lazy')
    if l:opts.lazy
      call add(s:lazy_plugs, l:name)
    endif
  endif

  call add(s:plugins, [a:repo, l:opts])
endfunction

com! -nargs=+ Pac call <SID>packager_add(<args>)

" Load lazy plugins. {{{1
let s:idx = 0
function! PackAddHandler(timer)
  exe 'packadd ' . s:lazy_plugs[s:idx]
  let s:idx += 1
  " doautocmd BufReadPost
  au! lazy_load_bundle
  if s:idx == len(s:lazy_plugs)
    echom "lazy load done !"
  endif
endfunction

aug lazy_load_bundle
  au MyAutoCmd VimEnter * call timer_start(0, 'PackAddHandler', {'repeat': len(s:lazy_plugs)})
aug END

" Plugin list. {{{1
source $VIM_PATH/start.vim
source $VIM_PATH/opt.vim
source $VIM_PATH/lazy.vim

" Plugin settings. {{{1
source $VIM_PATH/rc/plugin.vim

" Define user commands for updating/cleaning the plugins. {{{1
" Each of them loads packager, reloads .vimrc to register the
" information of plugins, then performs the task.
com! PackagerInstall call PackInit() | call packager#install()
com! PackagerUpdate call PackInit() | call packager#update()
com! PackagerClean call PackInit() | call packager#clean()
com! PackagerStatus call PackInit() | call packager#status()

" Install on initiall setup.
if s:packager_download
  PackagerInstall
endif
