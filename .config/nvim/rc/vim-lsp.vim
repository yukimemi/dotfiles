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
  setlocal shortmess+=c
  nmap <silent><buffer> gd <plug>(lsp-definition)
  nmap <silent><buffer> gy <Plug>(lsp-type-definition)
  nmap <silent><buffer> gr <plug>(lsp-references)
  nmap <silent><buffer> gi <plug>(lsp-implementation)
  " nmap <silent><buffer> K <plug>(lsp-hover)
  nmap <silent><buffer> <localleader>s :<c-u>split \| :LspDefinition<cr>
  nmap <silent><buffer> <localleader>v :<c-u>vsplit \| :LspDefinition<cr>
  nmap <silent><buffer> <f2> <plug>(lsp-rename)
  nnoremap <silent><buffer> K :<c-u>call <SID>show_documentation()<cr>

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent><buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <silent><buffer> [g <plug>(lsp-previous-diagnostic)

  " Remap for format selected region
  vmap <silent><buffer> <localleader>f <plug>(lsp-document-range-format)
  nmap <silent><buffer> <localleader>f <plug>(lsp-document-format)

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  vmap <silent><buffer> <localleader>a <Plug>(lsp-code-action)

  au MyAutoCmd BufWritePre <buffer> LspDocumentFormat
endfunction

au MyAutoCmd User lsp_buffer_enabled call <SID>on_lsp_buffer_enabled()
" au MyAutoCmd CmdwinEnter call lsp#enable()
" au MyAutoCmd CmdwinLeave call lsp#disable()

" Close preview window with <esc>
au MyAutoCmd User lsp_float_opened silent! nmap <buffer> <silent> <esc> <Plug>(lsp-preview-close)
au MyAutoCmd User lsp_float_closed silent! nunmap <buffer> <esc>

