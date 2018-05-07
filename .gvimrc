" ========== Basics ============================== {{{1


" ========== Appearance ========================== {{{1
" hide all
set guioptions=

" color
set background=dark
colorscheme PaperColor

" font
set gfn=Cica:h10:cSHIFTJIS:qDRAFT
set gfw=Cica:h10:cSHIFTJIS:qDRAFT
set printfont=Cica:h8
"set gfn=Ricty_Diminished_Discord:h10:cSHIFTJIS:qDRAFT
"set gfw=Ricty_Diminished_Discord:h10:cSHIFTJIS:qDRAFT

" only mac
if g:is_darwin
  gui
  set transparency=5
  set antialias
elseif g:is_windows
  gui
  set rop=type:directx,renmode:5
  set transparency=240
endif

if g:is_darwin
  if has("gui_running")
    set fuoptions=maxvert,maxhorz
    nnoremap [Space]r :<C-u>set nofullscreen<CR>
    nnoremap [Space]x :<C-u>set fullscreen<CR>
  endif
elseif g:is_windows
  if has("gui_running")
    nnoremap [Space]r :<C-u>simalt ~r<CR>
    nnoremap [Space]x :<C-u>simalt ~x<CR>
    " au MyAutoCmd GUIEnter * set lines=70 columns=100
  endif
endif

let g:save_window_file = expand('$CACHE/.vimwinpos')
au MyAutoCmd VimLeavePre * call s:save_window()
function! s:save_window()
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

set ambiwidth=double

