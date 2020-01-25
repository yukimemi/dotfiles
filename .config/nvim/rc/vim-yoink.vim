if !IsInstalled("autoload/yoink.vim")
  finish
endif

let g:yoinkMaxItems = 10000
let g:yoinkSavePersistently = 1

nmap <c-p> <plug>(YoinkPostPasteSwapBack)
nmap <c-n> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)<Plug>(shiny-p)
nmap P <plug>(YoinkPaste_P)<Plug>(shiny-P)

" nmap y <plug>(YoinkYankPreserveCursorPosition)
" xmap y <plug>(YoinkYankPreserveCursorPosition)
