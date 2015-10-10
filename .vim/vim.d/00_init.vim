" Release autogroup in MyAutoCmd"{{{
augroup MyAutoCmd
  autocmd!
augroup END
"}}}

" Echo startup time on start"{{{
if has('vim_starting') && has('reltime')
  let g:startuptime = reltime()
  au MyAutoCmd VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
        \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
endif
"}}}

" Restore last cursor position when open a file"{{{
au MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"}}}

" vim config path"{{{
if isdirectory($HOME . '/.vim')
  let $MY_VIMRUNTIME = $HOME . '/.vim'
elseif isdirectory($HOME . '\vimfiles')
  let $MY_VIMRUNTIME = $HOME . '\vimfiles'
elseif isdirectory($VIM . '\vimfiles')
  let $MY_VIMRUNTIME = $VIM . '\vimfiles'
endif
"}}}

" Judge os type"{{{
let g:is_windows = has('win16') || has('win32') || has('win64')
let g:is_cygwin = has('win32unix')
let g:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let g:is_linux = !g:is_windows && !g:is_cygwin && !g:is_darwin
"}}}

function! Mkdir(dir)"{{{
  if !isdirectory(a:dir)
    call mkdir(a:dir, "p")
  endif
endfunction
"}}}

function! Source(path)"{{{
  execute 'source' fnameescape(expand($MY_VIMRUNTIME . '/vim.d/' . a:path))
endfunction
"}}}

