" hide all
set guioptions=

" color
set background=dark

" font
Guifont! Cica:h11
" set gfn=Cica:h11
" set gfw=Cica:h11

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

