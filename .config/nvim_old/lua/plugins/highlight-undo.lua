return {
  "yuki-yano/highlight-undo.nvim",

  enabled = false,

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    require("highlight-undo").setup()
  end,
}
