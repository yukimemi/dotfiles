return {
  "nvim-tree/nvim-web-devicons",

  event = "VeryLazy",

  config = function()
    require("nvim-web-devicons").setup({ default = true })
  end,
}
