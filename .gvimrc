" ========== Appearance ========================== {{{1
" hide all
set guioptions=

" color
set background=dark
silent! colorscheme gruvbox-material
if g:no_plugin
  colorscheme desert
endif

" font
set gfn=Utatane:h12:cSHIFTJIS:qDRAFT
set gfw=Utatane:h12:cSHIFTJIS:qDRAFT
set printfont=Utatane:h8
"set gfn=Ricty_Diminished_Discord:h10:cSHIFTJIS:qDRAFT
"set gfw=Ricty_Diminished_Discord:h10:cSHIFTJIS:qDRAFT

" gui
set rop=type:directx,renmode:5
" set transparency=240

" nnoremap <Leader>r :<C-u>simalt ~r<CR>
" nnoremap <Leader>x :<C-u>simalt ~x<CR>
" au MyAutoCmd GUIEnter * set lines=70 columns=100

let g:save_window_file = expand("~/.vimwinpos")
au MyAutoCmd VimLeavePre * call s:save_window()
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

