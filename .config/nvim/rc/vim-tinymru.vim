nmap mru <Plug>(tinymru-mru-open)
nmap mrw <Plug>(tinymru-mrw-open)

let g:tinymru.max = 10000
let g:tinymru.mru = expand('$CACHE_HOME/vim_mru')
let g:tinymru.mrw = expand('$CACHE_HOME/vim_mrw')
