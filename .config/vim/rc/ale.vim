let g:ale_linters = {
			\ 'go': ['golint', 'go vet', 'goimports'],
			\ 'haskell': ['hlint'],
			\ 'python': ['flake8'],
			\ }
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)

let g:ale_fix_on_save = 1
let g:ale_fixers = {
			\ 'javascript': ['prettier'],
			\ 'javascript.jsx': ['prettier'],
			\ 'typescript': ['prettier'],
			\ 'json': ['prettier'],
			\ 'markdown': ['prettier'],
			\ 'html': ['prettier'],
			\ 'scss': ['prettier'],
			\ 'typescript.tsx': ['prettier'],
			\ 'sh': ['shfmt'],
			\ 'elm': ['elm-format'],
			\ 'python': ['autopep8', 'yapf', 'isort'],
			\ 'rust': ['rustfmt'],
			\ 'go': ['gofmt', 'goimports']
			\ }

let g:ale_completion_autoimport = 1

" rust
let g:ale_rust_rls_toolchain = 'stable'
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

