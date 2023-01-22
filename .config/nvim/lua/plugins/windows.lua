return {
  "anuvyklack/windows.nvim",

  event = "VeryLazy",

  dependencies = {
    { "anuvyklack/middleclass" },
    { "anuvyklack/animation.nvim" },
  },

  config = function()
    require("windows").setup({
      autowidth = {
        enable = true,
        winwidth = 5,
        filetype = {
          help = 2,
        },
      },
      ignore = {
        buftype = { "quickfix" },
        filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "aerial" },
      },
      animation = {
        enable = true,
        duration = 300,
        fps = 30,
        easing = "in_out_sine",
      },
    })
  end,

}
