" hide all
set guioptions=

" color
set background=dark
colorscheme gruvbox-material

" font
" GuiFont! Cica:h13
" set guifont=Utatane:h13
" set guifontwide=Utatane:h13

let g:save_window_file = expand("~/.nvimwinpos")
au MyAutoCmd VimLeavePre * call <SID>save_window()
function! s:save_window() abort
  let options = [
        \ 'set columns=' . &columns,
        \ 'set lines=' . &lines,
        \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
        \ ]
  call writefile(options, g:save_window_file)
endfunction

if filereadable(g:save_window_file)
  au MyAutoCmd GUIEnter * exe 'source' g:save_window_file
endif

" set ambiwidth=double

