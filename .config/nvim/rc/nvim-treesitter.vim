silent! packadd nvim-treesitter

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

let s:save_shellslash = &shellslash
set noshellslash
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 5000,
  },
}
EOF

let &shellslash = s:save_shellslash
unlet s:save_shellslash

