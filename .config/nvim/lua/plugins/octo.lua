return {
  "pwntester/octo.nvim",

  enabled = function()
    return vim.fn.executable("gh") > 0
  end,

  depencencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },

  cmd = "Octo",

  config = function()
    require("octo").setup()
  end,
}

