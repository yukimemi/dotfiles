let g:OmniSharp_selector_ui = 'ctrlp'
if g:is_darwin
  let g:OmniSharp_server_use_mono = 1
endif
" Show type information automatically when the cursor stops moving
au MyAutoCmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

" The following commands are contextual, based on the cursor position.
au MyAutoCmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<cr>

" Finds members in the current buffer
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<cr>

au MyAutoCmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <c-\> :OmniSharpSignatureHelp<cr>
au MyAutoCmd FileType cs inoremap <buffer> <c-\> <c-o>:OmniSharpSignatureHelp<cr>

" Navigate up and down by method/property/field
au MyAutoCmd FileType cs nnoremap <buffer> <c-k> :OmniSharpNavigateUp<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <c-j> :OmniSharpNavigateDown<cr>

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
au MyAutoCmd FileType cs nnoremap <buffer> <Leader><Space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
au MyAutoCmd FileType cs xnoremap <buffer> <Leader><Space> :call OmniSharp#GetCodeActions('visual')<cr>

" Rename with dialog
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>nm :OmniSharpRename<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <F2> :OmniSharpRename<cr>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
au MyAutoCmd FileType cs command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

au MyAutoCmd FileType cs nnoremap <buffer> <Leader>cf :OmniSharpCodeFormat<cr>

" Start the omnisharp server for the current solution
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>ss :OmniSharpStartServer<cr>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>th :OmniSharpHighlightTypes<cr>

