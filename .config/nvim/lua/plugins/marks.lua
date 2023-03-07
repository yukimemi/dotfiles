return {
  "chentoast/marks.nvim",

  enabled = vim.g.plugin_use_marks,

  event = "VeryLazy",

  config = function()
    require("marks").setup()
  end,
}
