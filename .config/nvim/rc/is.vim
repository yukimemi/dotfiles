" map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
" map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)

map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)zv
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)zv
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)zv
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)zv

nnoremap <silent> <expr> n anzu#mode#mapexpr("n", "", "zv")
nnoremap <silent> <expr> N anzu#mode#mapexpr("N", "", "zv")
