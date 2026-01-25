return {
  "sindrets/diffview.nvim",

  cmd = "DiffviewOpen",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    require("diffview").setup()
  end,
}

