" =============================================================================
" File        : minpac.vim
" Author      : yukimemi
" Last Change : 2021/11/22 09:59:45.
" =============================================================================

" Plugin:
" Use minpac.
let $CACHE_HOME_VIM = expand('$CACHE_HOME/vim')
set packpath^=$CACHE_HOME_VIM
let s:package_home = $CACHE_HOME_VIM . '/pack/minpac'
let s:minpac_dir = s:package_home . '/opt/minpac'
let s:minpac_download = 0
if has('vim_starting')
  if !isdirectory(expand(s:minpac_dir))
    echo "Install minpac ..."
    execute 'silent! !git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
    let s:minpac_download = 1
  endif
endif

function! IsInstalled(name) abort
  return !empty(globpath(&pp, "pack/minpac/*/" . a:name))
endfunction

let s:TYPE = {
      \   'string':  type(''),
      \   'list':    type([]),
      \   'dict':    type({}),
      \   'funcref': type(function('call'))
      \ }
let s:repos = {}
let s:cfg_path = $VIM_PATH . '/rc'

" Helper function.
function! s:plug_add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  let l:name = substitute(a:repo, '^.*/', '', '')
  let l:type = get(l:opts, 'type', 'start')

  " Check if option
  if has_key(l:opts, 'if')
    if ! l:opts.if
      return
    endif
  endif

  " Check ft option
  if has_key(l:opts, 'ft')
    let l:opts['type'] = 'opt'
    let l:ft = type(l:opts.ft) == s:TYPE.list ? join(l:opts.ft, ',') : l:opts.ft
    execute printf('au MyAutoCmd FileType %s packadd %s', l:ft, l:name)
  endif

  " Check cmd option
  if has_key(l:opts, 'cmd')
    let l:opts['type'] = 'opt'
    let l:cmd = type(l:opts.cmd) == s:TYPE.list ? join(l:opts.cmd, ',') : l:opts.cmd
    execute printf('au MyAutoCmd CmdUndefined %s packadd %s', l:cmd, l:name)
  endif

  " Check event
  if has_key(l:opts, 'event')
    let l:opts['type'] = 'opt'
    let l:event = type(l:opts.event) == s:TYPE.list ? join(l:opts.event, ',') : l:opts.event
    execute printf('au MyAutoCmd %s * ++once packadd %s', l:event, l:name)
  endif

  " source config
  let l:plug_cfg = expand(s:cfg_path . '/' . l:name)
  let l:plug_cfg_vim = expand(s:cfg_path . '/' . l:name . '.vim')
  if filereadable(l:plug_cfg)
    execute printf('so %s', l:plug_cfg)
  elseif filereadable(l:plug_cfg_vim)
    execute printf('so %s', l:plug_cfg_vim)
  endif

  let s:repos[a:repo] = l:opts
endfunction

command! -bar -nargs=+ Pg call s:plug_add(<args>)

" Load packager only when you need it
function! PackInit() abort
  packadd minpac
  call minpac#init()
  for [repo, opts] in items(s:repos)
    call minpac#add(repo, opts)
  endfor
endfunction

" Plugin list.
source $VIM_PATH/pluginslist.vim

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#clean() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

" Install on initiall setup.
if s:minpac_download
  PackUpdate
endif


