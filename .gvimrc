" ========== Basics ============================== {{{1


" ========== Appearance ========================== {{{1
" hide all
set guioptions=none

" color
set background=dark
" colorscheme molokai
colorscheme hybrid_material

" font
if g:is_windows
  " set gfn=MS_Gothic:h9:cSHIFTJIS
  set gfn=MS_Gothic:h9
  " set gfn=Ricty_Diminished:h9:cSHIFTJIS
  " set gfn=RzRicty_Diminished_Discord:h9:cSHIFTJIS
  " set gfw=MS_Gothic:h9:cSHIFTJIS
  set gfw=MS_Gothic:h9
  " set gfw=Ricty_Diminished:h9:cSHIFTJIS
  " set gfw=Ricty_Diminished_Discord:h9:cSHIFTJIS
  set rop=type:directx
else
  set gfn=Ricty\ Diminished\ Discord\ Regular:h18
  set gfw=Ricty\ Diminished\ Discord\ Regular:h18
endif

" only mac
if g:is_darwin
  gui
  set transparency=5
  set antialias
elseif g:is_windows
  gui
  set transparency=240
endif

if g:is_darwin
  if has("gui_running")
    set fuoptions=maxvert,maxhorz
    "au MyAutoCmd GUIEnter * set fullscreen
    nnoremap [Space]r :<C-u>set nofullscreen<CR>
    nnoremap [Space]x :<C-u>set fullscreen<CR>
  endif
elseif g:is_windows
  if has("gui_running")
    " initiallize size
    " set lines=130
    " set columns=120
    nnoremap [Space]r :<C-u>simalt ~r<CR>
    nnoremap [Space]x :<C-u>simalt ~x<CR>
    "au MyAutoCmd GUIEnter * simalt ~x
    "au MyAutoCmd FileType vimfiler simalt ~x
    "au MyAutoCmd BufLeave,BufHidden,BufDelete,VimLeave vimfiler simalt ~r<CR>
    "au MyAutoCmd BufEnter * macaction performZoom:
  endif
endif

set ambiwidth=double

