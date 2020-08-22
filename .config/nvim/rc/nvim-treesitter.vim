if !IsInstalled("nvim-treesitter")
  finish
endif

silent! packadd nvim-treesitter

lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    }
  },
  refactor = {
    highlight_defintions = {
      enable = true
    },
    smart_rename = {
      enable = true,
      smart_rename = "grr"
    },
    navigation = {
      enable = true,
      goto_definition = "gnd",
      list_definitions = "gnD"
    }
  },
  ensure_installed = 'all'
}
EOF
