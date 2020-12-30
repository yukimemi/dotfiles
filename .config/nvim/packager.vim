" =============================================================================
" File        : packager.vim
" Author      : yukimemi
" Last Change : 2020/12/30 14:21:25.
" =============================================================================

" Plugin:
" Use packager. {{{1
set packpath^=$CACHE_HOME
let s:package_home = $CACHE_HOME . '/pack/packager'
let s:packager_dir = s:package_home . '/opt/vim-packager'
let s:packager_download = v:false
if has('vim_starting')
  if !isdirectory(s:packager_dir)
    echo "Install vim-packager ..."
    execute '!git clone --depth 1 https://github.com/kristijanhusak/vim-packager ' . s:packager_dir
    let s:packager_download = v:true
  endif
endif

function! IsInstalled(name) abort
  return !empty(globpath(&pp, "pack/packager/*/" . a:name))
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
function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  for [repo, opts] in items(s:repos)
    call packager#add(repo, opts)
  endfor
endfunction

source $VIM_PATH/pluginslist.vim

" These commands are automatically added when using `packager#setup()`
command! -nargs=* -bar PackagerInstall call PackagerInit() | call packager#install(<args>)
command! -nargs=* -bar PackagerUpdate call PackagerInit() | call packager#update(<args>)
command! -bar PackagerClean call PackagerInit() | call packager#clean()
command! -bar PackagerStatus call PackagerInit() | call packager#status()

