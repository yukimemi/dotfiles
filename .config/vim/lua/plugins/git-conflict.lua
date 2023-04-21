return {
  "akinsho/git-conflict.nvim",

  event = "VeryLazy",

  config = function()
    require("git-conflict").setup()
  end,
}

