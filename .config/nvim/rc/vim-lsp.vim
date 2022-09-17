if !g:plugin_use_vimlsp
  finish
endif

function! Showdocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    LspHover
  endif
endfunction

let g:lsp_diagnostics_float_cursor = 1
let g:lsp_format_sync_timeout = 5000
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_signature_help_enabled = 0
let g:lsp_signature_help_delay = 1000

function! s:on_lsp_buffer_enabled() abort
  setlocal completeopt+=preview
  setlocal completeopt-=noinsert
  setlocal omnifunc=lsp#complete
  setlocal shortmess+=c
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  " Keymap n <silent><buffer> K <plug>(lsp-hover)
  " Keymap n <silent><buffer> <expr><c-d> lsp#scroll(-4)
  " Keymap n <silent><buffer> <expr><c-f> lsp#scroll(+4)
  Keymap n <silent><buffer> <f2> <plug>(lsp-rename)
  Keymap n <silent><buffer> <leader>f <plug>(lsp-document-format)
  Keymap n <silent><buffer> <localleader>s <cmd>split \| :LspDefinition<cr>
  Keymap n <silent><buffer> <localleader>v <cmd>vsplit \| :LspDefinition<cr>
  Keymap n <silent><buffer> K <cmd>call Showdocumentation()<cr>
  Keymap n <silent><buffer> [g <plug>(lsp-previous-diagnostic)
  Keymap n <silent><buffer> ]g <plug>(lsp-next-diagnostic)
  Keymap n <silent><buffer> gS <plug>(lsp-workspace-symbol-search)
  Keymap n <silent><buffer> gd <plug>(lsp-definition)
  Keymap n <silent><buffer> gi <plug>(lsp-implementation)
  Keymap n <silent><buffer> gr <plug>(lsp-references)
  Keymap n <silent><buffer> gs <plug>(lsp-document-symbol-search)
  Keymap n <silent><buffer> gy <Plug>(lsp-type-definition)
  Keymap x <silent><buffer> <localleader>a <Plug>(lsp-code-action)
  Keymap x <silent><buffer> <localleader>f <plug>(lsp-document-range-format)

  " au MyAutoCmd BufWritePre <buffer> LspDocumentFormatSync
  " au MyAutoCmd BufWritePre <buffer> call timer_start(0, { -> execute('LspDocumentFormatSync') })
  " au MyAutoCmd BufWritePre <buffer> LspDocumentFormat
endfunction

au MyAutoCmd User lsp_buffer_enabled call <SID>on_lsp_buffer_enabled()
" au MyAutoCmd CmdwinEnter call lsp#enable()
" au MyAutoCmd CmdwinLeave call lsp#disable()

" Close preview window with <esc>
au MyAutoCmd User lsp_float_opened silent! Keymap n <buffer> <silent> <esc> <Plug>(lsp-preview-close)
au MyAutoCmd User lsp_float_closed silent! nunmap <buffer> <esc>

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/.vim-lsp.log')

