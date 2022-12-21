return {
  "yukimemi/dps-ahdr",

  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g.ahdr_debug = false
    vim.g.ahdr_cfg_path = vim.fn.expand("~/.config/nvim/ahdr.toml")
  end,
}
