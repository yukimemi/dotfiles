let g:OmniSharp_selector_ui = 'ctrlp'
if g:is_darwin
  let g:OmniSharp_server_use_mono = 1
endif
" Show type information automatically when the cursor stops moving
au MyAutoCmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

" The following commands are contextual, based on the cursor position.
au MyAutoCmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <leader>fi :OmniSharpFindImplementations<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <leader>fs :OmniSharpFindSymbol<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <leader>fu :OmniSharpFindUsages<cr>

" Finds members in the current buffer
au MyAutoCmd FileType cs nnoremap <buffer> <leader>fm :OmniSharpFindMembers<cr>

au MyAutoCmd FileType cs nnoremap <buffer> <leader>fx :OmniSharpFixUsings<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <leader>tt :OmniSharpTypeLookup<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <leader>dc :OmniSharpDocumentation<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <c-\> :OmniSharpSignatureHelp<cr>
au MyAutoCmd FileType cs inoremap <buffer> <c-\> <c-o>:OmniSharpSignatureHelp<cr>

" Navigate up and down by method/property/field
au MyAutoCmd FileType cs nnoremap <buffer> <c-k> :OmniSharpNavigateUp<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <c-j> :OmniSharpNavigateDown<cr>

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
au MyAutoCmd FileType cs nnoremap <buffer> <leader><Space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
au MyAutoCmd FileType cs xnoremap <buffer> <leader><Space> :call OmniSharp#GetCodeActions('visual')<cr>

" Rename with dialog
au MyAutoCmd FileType cs nnoremap <buffer> <leader>nm :OmniSharpRename<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <F2> :OmniSharpRename<cr>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
au MyAutoCmd FileType cs command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

au MyAutoCmd FileType cs nnoremap <buffer> <leader>cf :OmniSharpCodeFormat<cr>

" Start the omnisharp server for the current solution
au MyAutoCmd FileType cs nnoremap <buffer> <leader>ss :OmniSharpStartServer<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
au MyAutoCmd FileType cs nnoremap <buffer> <leader>th :OmniSharpHighlightTypes<cr>

