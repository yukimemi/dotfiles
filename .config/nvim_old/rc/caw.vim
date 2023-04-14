if !g:plugin_use_caw
  finish
endif

Keymap nx gc <Plug>(caw:prefix)
Keymap nx gcc <Plug>(caw:hatpos:toggle)
