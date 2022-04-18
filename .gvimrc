" hide all
set guioptions=
set fillchars=vert:\|,fold:-,diff:-
set listchars=tab:\¦\ ,trail:-,extends:»,precedes:«,nbsp:%
set ambiwidth=double

" color
let s:no_plugin = get(g:, "no_plugin", v:false)
if s:no_plugin
  colorscheme desert
endif

set background=dark
silent! colorscheme pinkmare

" font
" set gfn=PlemolJP_Console_NF:h11
" set gfw=PlemolJP_Console_NF:h11
" set printfont=PlemolJP_Console_NF:h11
" set gfn=UDEV_Gothic_NF:h11
" set gfw=UDEV_Gothic_NF:h11
" set printfont=UDEV_Gothic_NF:h11
set gfn=Cica:h11
set gfw=Cica:h11
set printfont=Cica:h11

" gui
set rop=type:directx,renmode:5

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

