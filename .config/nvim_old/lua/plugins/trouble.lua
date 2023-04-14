return {
  "folke/trouble.nvim",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  cmd = { "TroubleToggle", "Trouble" },

  init = function()
    vim.keymap.set("n", "<space>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Trouble" })
  end,

  config = function()
    require("trouble").setup({
      auto_open = false,
      use_diagnostic_signs = true,
    })
  end,
}
