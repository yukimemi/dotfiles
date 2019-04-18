" =============================================================================
" File        : before.vim
" Author      : yukimemi
" Last Change : 2019/04/17 14:29:42.
" =============================================================================

" Init: {{{1
" Release autogroup in MyAutoCmd.
augroup MyAutoCmd
  autocmd!
augroup END

" Echo startup time on start.
if has('vim_starting') && has('reltime')
  let s:startuptime = reltime()
  au MyAutoCmd VimEnter * let s:startuptime = reltime(s:startuptime) | redraw
        \ | echomsg 'startuptime: ' . reltimestr(s:startuptime)
endif

" Set mapleader.
let mapleader = ','
let maplocalleader = ','

" PATH.
let $SPACE_VIM = expand("~/.SpaceVim.d")

" Utility: {{{1
" Judge os type. {{{2
let g:is_windows = has("win16") || has("win32") || has("win64")
let g:is_cygwin = has("win32unix")
let g:is_darwin = has("mac") || has("macunix") || has("gui_macvim")
let g:is_linux = !g:is_windows && !g:is_cygwin && !g:is_darwin

" SpaceVim config. {{{2
if g:is_windows
  let g:spacevim_disabled_plugins = ["denite.nvim"]
  let g:spacevim_autocomplete_method = "completor"
endif

" Functions: {{{1
function! Mkdir(dir) "{{{2
  if !isdirectory(a:dir)
    call mkdir(a:dir, "p")
  endif
endfunction


" vim: fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
