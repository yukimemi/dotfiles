if !g:plugin_use_ddc
	finish
endif

function! s:pum_cfg() abort
  call pum#set_option({
        \  'highlight_kind': 'Type',
        \  'max_width': 100,
        \  'use_complete': v:true,
        \ })
endfunction

au MyAutoCmd InsertEnter * ++once call s:pum_cfg()
