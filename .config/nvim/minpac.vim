" =============================================================================
" File        : minpac.vim
" Author      : yukimemi
" Last Change : 2020/01/01 02:07:00.
" =============================================================================

" Plugin:
" Use minpac. {{{1
set packpath^=$CACHE_HOME
let s:package_home = $CACHE_HOME . '/pack/minpac'
let s:minpac_dir = s:package_home . '/opt/minpac'
let s:minpac_download = 0
if has('vim_starting')
  if !isdirectory(s:minpac_dir)
    echo "Install minpac ..."
    execute '!git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
    let s:minpac_download = 1
  endif
endif

" ---------------------------------------------------------------------
" Author:  Ben Yip (yebenmy@protonmail.com)
" URL:     https://github.com/bennyyip/plugpac.vim
" Version: 1.0
" License: MIT
" ---------------------------------------------------------------------
let s:TYPE = {
      \   'string':  type(''),
      \   'list':    type([]),
      \   'dict':    type({}),
      \   'funcref': type(function('call'))
      \ }

function! s:plugpac_begin()
  let s:lazy = { 'ft': {}, 'map': {}, 'cmd': {}, 'lazy': {}, 'if': {} }
  let s:repos = {}
  let s:lazy_plugs = []

  call s:setup_command()
endfunction

function! s:plugpac_end()
  for [l:name, l:cmds] in items(s:lazy.cmd)
    for l:cmd in l:cmds
      " echom printf("command! -nargs=* -range -bang %s packadd %s | call s:do_cmd('%s', \"<bang>\", <line1>, <line2>, <q-args>)", l:cmd, l:name, l:cmd)
      execute printf("command! -nargs=* -range -bang %s packadd %s | call s:do_cmd('%s', \"<bang>\", <line1>, <line2>, <q-args>)", l:cmd, l:name, l:cmd)
    endfor
  endfor

  for [l:name, l:maps] in items(s:lazy.map)
    for l:map in l:maps
      for [l:mode, l:map_prefix, l:key_prefix] in
            \ [['i', '<C-O>', ''], ['n', '', ''], ['v', '', 'gv'], ['o', '', '']]
        execute printf(
        \ '%snoremap <silent> %s %s:<C-U>packadd %s<bar>call <SID>do_map(%s, %s, "%s")<CR>',
        \  l:mode, l:map, l:map_prefix, l:name, string(l:map), l:mode != 'i', l:key_prefix)
      endfor
    endfor
  endfor

  runtime! OPT ftdetect/**/*.vim
  runtime! OPT after/ftdetect/**/*.vim

  for [name, fts] in items(s:lazy.ft)
    execute printf('au MyAutoCmd FileType %s packadd %s', fts, name)
  endfor
endfunction

" https://github.com/k-takata/minpac/issues/28
function! s:plugpac_add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  let l:name = substitute(a:repo, '^.*/', '', '')

  " Check if option
  if has_key(l:opts, 'if')
    if ! l:opts.if
      return
    endif
  endif

  " `for`,'ft' and `on` implies optional
  if has_key(l:opts, 'for') || has_key(l:opts, 'on') || has_key(l:opts, 'ft')
    let l:opts['type'] = 'opt'
  endif

  if has_key(l:opts, 'for')
    let l:ft = type(l:opts.for) == s:TYPE.list ? join(l:opts.for, ',') : l:opts.for
    let s:lazy.ft[l:name] = l:ft
  endif
  if has_key(l:opts, 'ft')
    let l:ft = type(l:opts.ft) == s:TYPE.list ? join(l:opts.ft, ',') : l:opts.ft
    let s:lazy.ft[l:name] = l:ft
  endif

  if has_key(l:opts, 'on')
    for l:cmd in s:to_a(l:opts.on)
      if l:cmd =~? '^<Plug>.\+'
        if empty(mapcheck(l:cmd)) && empty(mapcheck(l:cmd, 'i'))
          call s:assoc(s:lazy.map, l:name, l:cmd)
        endif
      elseif cmd =~# '^[A-Z]'
        if exists(":".l:cmd) != 2
          call s:assoc(s:lazy.cmd, l:name, l:cmd)
        endif
      else
        call s:err('Invalid `on` option: '.cmd.
              \ '. Should start with an uppercase letter or `<Plug>`.')
      endif
    endfor
  endif

  " lazy plugins
  if has_key(l:opts, 'lazy')
    if l:opts.lazy
      call add(s:lazy_plugs, l:name)
    endif
  endif

  " Load plugi config if exist.
  if filereadable($VIM_PATH . '/rc/' . l:name)
    exe printf('source %s/rc/%s', $VIM_PATH, l:name)
  elseif filereadable($VIM_PATH . '/rc/' . l:name . '.vim')
    exe printf('source %s/rc/%s.vim', $VIM_PATH, l:name)
  endif

  let s:repos[a:repo] = l:opts
endfunction

function! s:plugpac_has_plugin(plugin)
  return index(s:get_plugin_list(), a:plugin) != -1
endfunction

function! s:assoc(dict, key, val)
  let a:dict[a:key] = add(get(a:dict, a:key, []), a:val)
endfunction

function! s:to_a(v)
  return type(a:v) == s:TYPE.list ? a:v : [a:v]
endfunction

function! s:err(msg)
  echohl ErrorMsg
  echom '[plugpac] '.a:msg
  echohl None
endfunction

function! s:do_cmd(cmd, bang, start, end, args)
  exec printf('%s%s%s %s', (a:start == a:end ? '' : (a:start.','.a:end)), a:cmd, a:bang, a:args)
endfunction

function! s:do_map(map, with_prefix, prefix)
  let extra = ''
  while 1
    let c = getchar(0)
    if c == 0
      break
    endif
    let l:extra .= nr2char(c)
  endwhile

  if a:with_prefix
    let prefix = v:count ? v:count : ''
    let prefix .= '"'.v:register.a:prefix
    if mode(1) == 'no'
      if v:operator == 'c'
        let prefix = "\<esc>" . prefix
      endif
      let prefix .= v:operator
    endif
    call feedkeys(prefix, 'n')
  endif
  call feedkeys(substitute(a:map, '^<Plug>', "\<Plug>", '') . extra)
endfunction

function! s:setup_command()
  command! -bar -nargs=+ Pac call s:plugpac_add(<args>)

  command! -bar PacInstall call s:init_minpac() | call minpac#update(keys(filter(copy(minpac#pluglist), {-> !isdirectory(v:val.dir . '/.git')})))
  command! -bar PacUpdate  call s:init_minpac() | call minpac#update('', {'do': 'call minpac#status()'})
  command! -bar PacClean   call s:init_minpac() | call minpac#clean()
  command! -bar PacStatus  call s:init_minpac() | call minpac#status()
  command! -bar -nargs=1 -complete=customlist,s:plugin_dir_complete PackDisable call s:disable_plugin(<q-args>)
endfunction

function! s:init_minpac()
  packadd minpac

  call minpac#init()
  for [repo, opts] in items(s:repos)
    call minpac#add(repo, opts)
  endfor
endfunction

function s:disable_plugin(plugin_dir, ...) abort
  if !isdirectory(a:plugin_dir)
    s:err(a:plugin_dir . 'not exists.')
    return
  endif
  let l:dst_dir = substitute(a:plugin_dir, '/start/\ze[^/]\+$', '/opt/', '')
  if isdirectory(l:dst_dir)
    s:err(l:dst_dir . 'exists.')
    return
  endif
  call rename(a:plugin_dir, l:dst_dir)
endfunction

function! s:plugin_dir_complete(A, L, P)
  let l:pat = 'pack/minpac/start/*'
  let l:plugin_list = filter(globpath(&packpath, l:pat, 0, 1), {-> isdirectory(v:val)})
  return filter(l:plugin_list, 'v:val =~ "'. a:A .'"')
endfunction

function! s:get_plugin_list()
  if exists("s:plugin_list")
    return s:plugin_list
  endif
  let l:pat = 'pack/*/*/*'
  let s:plugin_list = filter(globpath(&packpath, l:pat, 0, 1), {-> isdirectory(v:val)})
  call map(s:plugin_list, {-> substitute(v:val, '^.*[/\\]', '', '')})
  return s:plugin_list
endfunction

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
call s:plugpac_begin()
source $VIM_PATH/start.vim
source $VIM_PATH/opt.vim
source $VIM_PATH/lazy.vim
call s:plugpac_end()

" Install on initiall setup.
if s:minpac_download
  PacInstall
endif
