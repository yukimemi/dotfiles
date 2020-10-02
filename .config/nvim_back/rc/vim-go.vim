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

  nmap <buffer> <leader>gd <Plug>(go-doc)
  nmap <buffer> <leader>gs <Plug>(go-doc-split)
  nmap <buffer> <leader>gv <Plug>(go-doc-vertical)
  nmap <buffer> <leader>gb <Plug>(go-doc-browser)
  nmap <buffer> <leader>gr <Plug>(go-rename)

  " nmap <buffer> <leader>r <Plug>(go-run)
  nmap <buffer> <leader>gb <Plug>(go-build)
  nmap <buffer> <leader>gt <Plug>(go-test)
  nmap <buffer> <leader>gc <Plug>(go-coverage)

  nmap <buffer> <leader>ds <Plug>(go-def-split)
  nmap <buffer> <leader>dv <Plug>(go-def-vertical)
  nmap <buffer> <leader>dt <Plug>(go-def-tab)
  nnoremap <buffer> <leader>gi :<c-u>GoImport<Space>

  setl completeopt=menu,preview
endfunction

