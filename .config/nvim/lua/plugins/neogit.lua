return {
  "TimUntersberger/neogit",

  enabled = false,

  cmd = "Neogit",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    require("neogit").setup()
  end,
}
