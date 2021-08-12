" asyncomplete-nextword.
au MyAutoCmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#nextword#get_source_options({
      \ 'name': 'nextword',
      \ 'allowlist': ['*'],
      \ 'args': ['-n', '10000'],
      \ 'completor': function('asyncomplete#sources#nextword#completor')
      \ }))

" asyncomplete-buffer.
au MyAutoCmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'allowlist': ['*'],
      \ 'blocklist': ['go', 'rust'],
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ 'config': {
      \    'max_buffer_size': 5000000,
      \  },
      \ }))

" asyncomplete-file.
au MyAutoCmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#file#completor')
      \ }))

let g:lsp_diagnostics_float_cursor = 1

imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<c-g>u\<cr>"

command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log') | let g:asyncomplete_log_file = expand('~/asyncomplete.log')
