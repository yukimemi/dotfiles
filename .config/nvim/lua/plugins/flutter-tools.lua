return {
  "akinsho/flutter-tools.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "nvim-telescope/telescope.nvim",
  },

  ft = "dart",

  config = function()
    require("telescope").load_extension("flutter")

    require("flutter-tools").setup({
      debugger = {
        enabled = true,
      },
    })

    vim.keymap.set(
      "n",
      "<space>ff",
      "<cmd>lua require('telescope').extensions.flutter.commands()<cr>",
      { noremap = true }
    )
  end,
}
