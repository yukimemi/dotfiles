if !g:plugin_use_ddc
	finish
endif

if g:is_windows
  finish
endif

" if you use with vim-lsp, disable vim-lsp's signature help feature
if g:plugin_use_vimlsp
  let g:lsp_signature_help_enabled = v:false
else
  call signature_help#enable()
endif

