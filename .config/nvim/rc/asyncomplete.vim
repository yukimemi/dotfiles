" asyncomplete.vim {{{1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_force_refresh_on_context_changed = 1
imap <C-Space> <Plug>(asyncomplete_force_refresh)

" asyncomplete-buffer.vim {{{2
au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-buffer.vim | call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'whitelist': ['*'],
      \ 'priority': 1,
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ }))

" asyncomplete-file.vim {{{2
au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-file.vim | call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'whitelist': ['*'],
      \ 'priority': 1,
      \ 'completor': function('asyncomplete#sources#file#completor'),
      \ }))

" asyncomplete-emoji.vim {{{2
au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-emoji.vim | call asyncomplete#register_source(asyncomplete#sources#emoji#get_source_options({
      \ 'name': 'emoji',
      \ 'whitelist': ['*'],
      \ 'blacklist': ['rust'],
      \ 'priority': 1,
      \ 'completor': function('asyncomplete#sources#emoji#completor'),
      \ }))

" asyncomplete-tags.vim {{{2
if executable('ctags')
  au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-tags.vim | call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
        \ 'name': 'tags',
        \ 'whitelist': ['*'],
        \ 'priority': 2,
        \ 'completor': function('asyncomplete#sources#tags#completor'),
        \ 'config': {
        \    'max_file_size': 20000000,
        \ }
        \ }))
endif

" asyncomplete-neosnippet.vim {{{2
au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-neosnippet.vim | call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
      \ 'name': 'neosnippet',
      \ 'whitelist': ['*'],
      \ 'priority': 3,
      \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
      \ }))

" asyncomplete-necosyntax.vim {{{2
au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-necosyntax.vim | call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
      \ 'name': 'necosyntax',
      \ 'whitelist': ['*'],
      \ 'priority': 4,
      \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
      \ }))

" asyncomplete-necovim.vim {{{2
au MyAutoCmd FileType vim call <SID>asyncomplete_necovim_aft()
function! s:asyncomplete_necovim_aft() abort
  silent! packadd asyncomplete-necovim.vim
  call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
        \ 'name': 'necovim',
        \ 'whitelist': ['vim'],
        \ 'priority': 4,
        \ 'completor': function('asyncomplete#sources#necovim#completor'),
        \ }))
endfunction

" vim-lsp. {{{2
let g:lsp_signs_enabled = 1
let g:lsp_auto_enable = 1
let g:lsp_insert_text_enabled = 1
let g:lsp_async_completion = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

nmap <silent> gd <plug>(lsp-definition)
nmap <silent> gp <plug>(lsp-hover)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> gi <plug>(lsp-implementation)
nmap <silent> <Leader>s :<C-u>split \| :LspDefinition<CR>
nmap <silent> <Leader>v :<C-u>vsplit \| :LspDefinition<CR>

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

" debug. {{{1
if 0
  call Mkdir(expand('~/.log/vim'))
  let g:lsp_log_verbose = 1
  let g:lsp_log_file = expand('~/.log/vim/vim-lsp.log')

  " for asyncomplete.vim log
  let g:asyncomplete_log_file = expand('~/.log/vim/asyncomplete.log')
endif

