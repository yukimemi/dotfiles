"{{{ ========== Basics ================================================================
" OS judge
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let s:is_linux = !s:is_windows && !s:is_cygwin && !s:is_darwin

"===================================================================================}}}

"{{{ ========== Appearance ============================================================
" hide all
set guioptions=none

" color
colorscheme japanesque
set background=dark

" font
if s:is_windows
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
  set gfn=Ricty_Diminished:h18
  set gfw=Ricty_Diminished:h18
endif

" only mac
if s:is_darwin
  gui
  set transparency=5
  set antialias
elseif s:is_windows
  gui
  set transparency=240
endif

if s:is_darwin
  if has("gui_running")
    set fuoptions=maxvert,maxhorz
    "au MyAutoCmd GUIEnter * set fullscreen
    nnoremap [Space]r :<C-u>set nofullscreen<CR>
    nnoremap [Space]x :<C-u>set fullscreen<CR>
  endif
elseif s:is_windows
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
"===================================================================================}}}
