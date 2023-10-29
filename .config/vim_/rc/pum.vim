if !g:plugin_use_ddc
  finish
endif

call pum#set_option({
      \  'max_width': 150,
      \  'use_complete': v:true,
      \ })

