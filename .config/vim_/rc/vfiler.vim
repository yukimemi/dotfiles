if !g:plugin_use_vfiler
  finish
endif

Keymap n <silent> ge <cmd>VFiler -auto-cd -auto-resize -keep -layout=left -name=explorer -width=30 columns=indent,icon,name<cr>
