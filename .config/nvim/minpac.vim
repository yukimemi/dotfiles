" =============================================================================
" File        : minpac.vim
" Author      : yukimemi
" Last Change : 2019/01/02 22:30:22.
" =============================================================================

" Plugin:
" Use minpac. {{{1
set packpath^=$CACHE_HOME
let s:package_home = $CACHE_HOME . '/pack/packages'
let s:minpac_dir = s:package_home . '/opt/minpac'
let s:minpac_download = 0
if has('vim_starting')
  if !isdirectory(s:minpac_dir)
    echo "Install minpac ..."
    execute '!git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
    let s:minpac_download = 1
  endif
endif

" minpac init. {{{1
let s:plugins = []
function! PackInit() abort
  packadd minpac
  call minpac#init({'dir': $CACHE_HOME, 'package_name': 'packages'})
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  for plugin in s:plugins
    call minpac#add(plugin[0], plugin[1])
  endfor
endfunction

" minpac helper function. {{{1
let s:lazy_plugs = []
function! s:minpac_add(repo, ...) abort
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

  if has_key(l:opts, 'lazy')
    if l:opts.lazy
      call add(s:lazy_plugs, l:name)
    endif
  endif

  call add(s:plugins, [a:repo, l:opts])
endfunction

com! -nargs=+ Pac call <SID>minpac_add(<args>)

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
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
com! PackClean     call PackInit() | call minpac#clean()
com! PackUpdate    call PackInit() | call minpac#clean() | call minpac#update() | call minpac#status()
com! PackListStart call PackInit() | Capture echo minpac#getpackages("", "start")
com! PackListOpt   call PackInit() | Capture echo minpac#getpackages("", "opt")
com! PackNameStart call PackInit() | Capture echo minpac#getpackages("", "start", "", 1)
com! PackNameOpt   call PackInit() | Capture echo minpac#getpackages("", "opt", "", 1)
" Quit Vim immediately after all updates are finished.
com! PackUpdateQuit call PackInit() | call minpac#update('', {'do': 'quit'})

" Install on initiall setup.
if s:minpac_download
  PackUpdate
endif
