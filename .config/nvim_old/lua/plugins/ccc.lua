return {
  "uga-rosa/ccc.nvim",

  event = "BufEnter",

  config = function()
    require("ccc").setup()
  end

}
