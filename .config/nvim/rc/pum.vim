if !g:plugin_use_ddc
	finish
endif

au MyAutoCmd InsertEnter * ++once call pum#set_option({ 'border': "rounded" })
