" let g:is#do_default_mappings = 0

set ignorecase
set smartcase

map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)zv
map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)zv

map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)zv
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)zv
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)zv
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)zv

