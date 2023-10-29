return {
  "yuki-yano/tsnip.nvim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
    "MunifTanjim/nui.nvim",
  },

  init = function()
    vim.g.tsnip_snippet_dir = vim.fn.stdpath("config") .. "/tsnip"
  end
}

