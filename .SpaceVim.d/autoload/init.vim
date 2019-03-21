" =============================================================================
" File        : init.vim
" Author      : yukimemi
" Last Change : 2019/03/10 22:21:02.
" =============================================================================

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! init#before() abort
  execute 'source '.s:path.'/before.vim'
endfunction

function! init#after() abort
  execute 'source '.s:path.'/after.vim'
endfunction

" vim: fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
