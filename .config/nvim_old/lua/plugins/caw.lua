return {
  "tyru/caw.vim",

  enabled = vim.g.plugin_use_caw,

  dependencies = {
    "Shougo/context_filetype.vim",
    "kana/vim-operator-user",
    "kana/vim-repeat",
  },

  event = "VeryLazy",

  init = function()
    vim.g.caw_operator_keymappings = 0
  end,
}
