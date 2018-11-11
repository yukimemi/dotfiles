let g:ale_linters = {
      \ 'go': ['golint', 'go vet', 'goimports'],
      \ 'haskell': ['hlint']
      \ }
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
nmap <silent> z[ <Plug>(ale_previous_wrap)
nmap <silent> z] <Plug>(ale_next_wrap)

let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'javascript.jsx': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'json': ['prettier'],
      \ 'markdown': ['prettier'],
      \ 'scss': ['prettier'],
      \ 'typescript.tsx': ['prettier'],
      \ 'sh': ['shfmt'],
      \ 'elm': ['elm-format'],
			\ 'python': ['autopep8', 'black', 'isort'],
      \ }

" Rust.
let g:ale_rust_ignore_error_codes = ['E0432', 'E0433']
