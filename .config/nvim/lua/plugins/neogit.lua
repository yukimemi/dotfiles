return {
  "TimUntersberger/neogit",

  cmd = "Neogit",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    require("neogit").setup()
  end,
}
