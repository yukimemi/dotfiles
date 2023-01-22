return {
  "numToStr/Comment.nvim",

  enabled = true,

  keys = {
    { "gcc", mode = { "n", "x" } },
  },

  config = function()
    require('Comment').setup()
  end,
}
