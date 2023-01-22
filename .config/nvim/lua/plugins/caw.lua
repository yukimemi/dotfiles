return {
  "tyru/caw.vim",

  enabled = false,

  dependencies = {
    "Shougo/context_filetype.vim",
    "kana/vim-operator-user",
    "kana/vim-repeat",
  },

  event = "VeryLazy",

  init = function()
    vim.g.caw_operator_keymappings = 1
  end,
}
