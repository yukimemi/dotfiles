if !g:plugin_use_ddc
	finish
endif

function! s:pum_cfg() abort
  call pum#set_option({ 'border': "rounded" })
  call pum#set_option('max_width', 80)
  call pum#set_option('use_complete', v:true)
endfunction

au MyAutoCmd InsertEnter * ++once call s:pum_cfg()
