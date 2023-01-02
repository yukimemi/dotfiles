return {
  "uga-rosa/scorpeon.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.g.scorpeon_extensions_path = vim.fn.expand("~/.cache/scorpeon")
  end,
}
