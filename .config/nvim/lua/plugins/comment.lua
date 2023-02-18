return {
  "numToStr/Comment.nvim",

  enabled = vim.g.plugin_use_comment,

  keys = {
    { "gcc", mode = { "n", "x" } },
  },

  config = function()
    require("Comment").setup()
  end,
}
