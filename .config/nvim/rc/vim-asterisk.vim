if !IsInstalled("vim-asterisk")
  finish
endif

map *  <Plug>(asterisk-z*)zv
map g* <Plug>(asterisk-gz*)zv
map #  <Plug>(asterisk-z#)zv
map g# <Plug>(asterisk-gz#)zv
