if !g:plugin_use_vimlsp
  finish
endif

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    LspHover
  endif
endfunction

let g:lsp_diagnostics_float_cursor = 1
let g:lsp_format_sync_timeout = 3000
let g:lsp_diagnostics_virtual_text_enabled = 0

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  setlocal completeopt+=preview
  setlocal completeopt-=noinsert
  setlocal shortmess+=c
  Keymap n <silent><buffer> gd <plug>(lsp-definition)
  Keymap n <silent><buffer> gy <Plug>(lsp-type-definition)
  Keymap n <silent><buffer> gr <plug>(lsp-references)
  Keymap n <silent><buffer> gi <plug>(lsp-implementation)
  " Keymap n <silent><buffer> K <plug>(lsp-hover)
  Keymap n <silent><buffer> <localleader>s :<c-u>split \| :LspDefinition<cr>
  Keymap n <silent><buffer> <localleader>v :<c-u>vsplit \| :LspDefinition<cr>
  Keymap n <silent><buffer> <f2> <plug>(lsp-rename)
  Keymap n <silent><buffer> K :<c-u>call <SID>show_documentation()<cr>

  " Use `[g` and `]g` to navigate diagnostics
  Keymap n <silent><buffer> ]g <plug>(lsp-next-diagnostic)
  Keymap n <silent><buffer> [g <plug>(lsp-previous-diagnostic)

  " Remap for format selected region
  Keymap x <silent><buffer> <localleader>f <plug>(lsp-document-range-format)
  Keymap n <silent><buffer> <localleader>f <plug>(lsp-document-format)

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  Keymap x <silent><buffer> <localleader>a <Plug>(lsp-code-action)

  au MyAutoCmd BufWritePre <buffer> LspDocumentFormatSync
  " au MyAutoCmd BufWritePre <buffer> LspDocumentFormat
endfunction

au MyAutoCmd User lsp_buffer_enabled call <SID>on_lsp_buffer_enabled()
" au MyAutoCmd CmdwinEnter call lsp#enable()
" au MyAutoCmd CmdwinLeave call lsp#disable()

" Close preview window with <esc>
au MyAutoCmd User lsp_float_opened silent! Keymap n <buffer> <silent> <esc> <Plug>(lsp-preview-close)
au MyAutoCmd User lsp_float_closed silent! nunmap <buffer> <esc>

