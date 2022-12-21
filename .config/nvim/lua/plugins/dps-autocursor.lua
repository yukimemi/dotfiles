return {
  "yukimemi/dps-autocursor",

  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g.autocursor_debug = false
  end,
}
