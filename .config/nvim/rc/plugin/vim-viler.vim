" nnoremap <c-e> :<c-u>call viler#open(expand("%:p:h"))<cr>
nnoremap <c-e> :<c-u>call viler#open('.', {'do_before': 'vsplit'})<cr>

au MyAutoCmd FileType viler call <SID>my_viler_settings()

function! s:my_viler_settings() abort
	nmap <buffer> <c-h> <Plug>(viler-cd-up)
	nmap <buffer> <c-l> <Plug>(viler-open-file)
	nmap <buffer> <cr>  <Plug>(viler-open-file)
	nmap <buffer> .     <Plug>(viler-toggle-dotfiles)
	nmap <buffer> <c-g> <Plug>(viler-refresh)
	" <Plug>(viler-toggle-tree)
	" 	Open/close a tree under the cursor.
	" <Plug>(viler-undo)
	" <Plug>(viler-redo)
	" 	Undo/redo on filer.
	" 	Note that Viler maps these keys for |u| and |CTRL-R| by default.
	" 	This is necessary to operate undo/redo with keep the filer state
endfunction

