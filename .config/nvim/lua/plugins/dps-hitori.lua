return {
  "yukimemi/dps-hitori",

  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g.hitori_debug = true
    vim.g.hitori_enable = true
    vim.g.hitori_quit = true
  end,
}
