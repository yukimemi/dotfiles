if !IsInstalled("asyncomplete.vim")
  finish
endif

" asyncomplete-buffer.
au MyAutoCmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'whitelist': ['*'],
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ 'config': {
      \    'max_buffer_size': 5000000,
      \  },
      \ }))

" asyncomplete-file.
au MyAutoCmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'whitelist': ['*'],
      \ 'completor': function('asyncomplete#sources#file#completor')
      \ }))

" asyncomplete-emoji.
au MyAutoCmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emoji#get_source_options({
      \ 'name': 'emoji',
      \ 'whitelist': ['*'],
      \ 'completor': function('asyncomplete#sources#emoji#completor'),
      \ }))

let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_text_edit_enabled = 1

imap <c-space> <Plug>(asyncomplete_force_refresh)
" inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  setlocal completeopt+=preview
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <silent> gr <plug>(lsp-references)
  nmap <silent> gi <plug>(lsp-implementation)
  nmap <silent> K <plug>(lsp-hover)
  nmap <silent> <Leader>s :<c-u>split \| :LspDefinition<cr>
  nmap <silent> <Leader>v :<c-u>vsplit \| :LspDefinition<cr>
  nmap <buffer> <f2> <plug>(lsp-rename)
endfunction

au MyAutoCmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()

command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log') | let g:asyncomplete_log_file = expand('~/asyncomplete.log')

