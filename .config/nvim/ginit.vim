" ========== Appearance ========================== {{{1
" hide all
set guioptions=

" color
set background=dark
colorscheme spring-night

" font
GuiFont! Cica:h12
set printfont=Cica:h8

nnoremap <Leader>r :<c-u>simalt ~r<cr>
nnoremap <Leader>x :<c-u>simalt ~x<cr>
" au MyAutoCmd GUIEnter * set lines=70 columns=100

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

