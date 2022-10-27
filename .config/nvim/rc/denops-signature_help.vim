if !g:plugin_use_ddc
	finish
endif

call signature_help#enable()

" if you use with vim-lsp, disable vim-lsp's signature help feature
let g:lsp_signature_help_enabled = v:false

