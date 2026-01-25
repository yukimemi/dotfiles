" =============================================================================
" File        : .gvimrc
" Author      : yukimemi
" Last Change : 2023/05/17 00:40:12.
" =============================================================================

" hide all
set guioptions=
set fillchars=vert:\|,fold:-,diff:-
set listchars=tab:\¦\ ,trail:-,extends:»,precedes:«,nbsp:%
set ambiwidth=double

set gfn=HackGen_Console_NF:h10:cSHIFTJIS:qDRAFT
set gfw=HackGen_Console_NF:h10:cSHIFTJIS:qDRAFT
set printfont=HackGen_Console_NF:h10:cSHIFTJIS:qDRAFT

" gui
set rop=type:directx,renmode:5

let g:save_window_file = expand("~/.vimwinpos")
au VimLeavePre * call s:save_window()
function! s:save_window() abort
  let options = [
        \ 'set columns=' . &columns,
        \ 'set lines=' . &lines,
        \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
        \ ]
  call writefile(options, g:save_window_file)
endfunction

if filereadable(g:save_window_file)
  au GUIEnter * exe 'source' g:save_window_file
endif

