if !IsInstalled("autoload/asterisk.vim")
  finish
endif

map *  <Plug>(asterisk-z*)zv
map g* <Plug>(asterisk-gz*)zv
map #  <Plug>(asterisk-z#)zv
map g# <Plug>(asterisk-gz#)zv
