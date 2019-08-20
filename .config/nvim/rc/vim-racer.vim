" au MyAutoCmd FileType rust call <SID>vim_racer_aft()
let g:racer_experimental_completer = 1

function! s:vim_racer_aft() abort
  packadd vim-racer
  setl completeopt=menu,preview
  nmap <buffer> gd <Plug>(rust-def)
  nmap <buffer> gs <Plug>(rust-def-split)
  nmap <buffer> gx <Plug>(rust-def-vertical)
  nmap <buffer> K <Plug>(rust-doc)
endfunction

