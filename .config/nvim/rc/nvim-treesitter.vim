if !g:plugin_use_treesitter
  finish
endif

silent! packadd nvim-treesitter

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "vim", "rust", "go", "toml"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang)
      local ok = pcall(function()
        vim.treesitter.get_query(lang, 'highlights')
      end)
      return not ok
    end,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 5000,
  },
}
EOF

