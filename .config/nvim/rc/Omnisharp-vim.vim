let g:OmniSharp_selector_ui = 'ctrlp'
if g:is_darwin
  let g:OmniSharp_server_use_mono = 1
endif
" Show type information automatically when the cursor stops moving
au MyAutoCmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

" The following commands are contextual, based on the cursor position.
au MyAutoCmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

" Finds members in the current buffer
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

au MyAutoCmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
au MyAutoCmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
au MyAutoCmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
au MyAutoCmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

" Navigate up and down by method/property/field
au MyAutoCmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
au MyAutoCmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Add syntax highlighting for types and interfaces
nnoremap <Leader>th :OmniSharpHighlightTypes<CR>

