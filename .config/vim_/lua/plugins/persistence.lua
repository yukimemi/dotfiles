return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  config = function()
    require("persistence").setup({
      options = { "buffers", "curdir", "tabpages", "winsize", "help" },
    })
  end,
}

