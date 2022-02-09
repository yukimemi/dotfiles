if !g:plugin_use_ddc
	finish
endif

let g:popup_preview_config = {
      \ 'delay': 100,
      \ 'border': v:true,
			\ 'maxWidth': 80,
			\ 'maxHeight': 30,
			\ }

call popup_preview#enable()

" au MyAutoCmd FileType ps1,vim call popup_preview#disable()

