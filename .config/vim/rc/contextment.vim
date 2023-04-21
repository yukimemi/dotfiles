if !g:plugin_use_contextment
  finish
endif

Keymap nx gc <Plug>(contextment)
Keymap n gcc <Plug>(contextment-line)
