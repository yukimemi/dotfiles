if !IsInstalled("yankround.vim")
  finish
endif

nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <c-p> <Plug>(yankround-prev)
nmap <c-n> <Plug>(yankround-next)
let g:yankround_max_history = 1000

