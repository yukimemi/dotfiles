return {
  "ray-x/sad.nvim",

  enabled = false,

  dependencies = {
    "ray-x/guihua.lua",
  },

  cmd = { "Sad" },

  config = function()
    require("sad").setup({
      debug = false,
      diff = "delta",
      ls_file = "fd",
      exact = false,
      vsplit = false,
      height_ratio = 0.7,
      width_ratio = 0.7,
    })
  end,
}
