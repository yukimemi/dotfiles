let g:go_auto_type_info = 1
let g:go_snippet_engine = "neosnippet"
let g:go_fmt_command = "goimports"

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_metalinter_autosave = 1
let g:go_fmt_autosave = 0
let g:go_gocode_unimported_packages = 1
" au MyAutoCmd BufWritePost *.go GoMetaLinter
" au MyAutoCmd BufWritePre *.go silent GoFmt

au MyAutoCmd BufNew,BufRead *.go call <SID>vim_go_cfg()

function! s:vim_go_cfg() abort
  packadd vim-go
  setl foldmethod=syntax
  setl tabstop=4
  setl shiftwidth=4
  setl softtabstop=0
  setl noexpandtab

  nmap <buffer> <Leader>gd <Plug>(go-doc)
  nmap <buffer> <Leader>gs <Plug>(go-doc-split)
  nmap <buffer> <Leader>gv <Plug>(go-doc-vertical)
  nmap <buffer> <Leader>gb <Plug>(go-doc-browser)
  nmap <buffer> <Leader>gr <Plug>(go-rename)

  " nmap <buffer> <Leader>r <Plug>(go-run)
  nmap <buffer> <Leader>gb <Plug>(go-build)
  nmap <buffer> <Leader>gt <Plug>(go-test)
  nmap <buffer> <Leader>gc <Plug>(go-coverage)

  nmap <buffer> <Leader>ds <Plug>(go-def-split)
  nmap <buffer> <Leader>dv <Plug>(go-def-vertical)
  nmap <buffer> <Leader>dt <Plug>(go-def-tab)
  nnoremap <buffer> <Leader>gi :<C-u>GoImport<Space>

  setl completeopt=menu,preview
endfunction

