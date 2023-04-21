return {
  "folke/todo-comments.nvim",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
    "folke/trouble.nvim",
  },

  cmd = {
    "TodoTrouble",
    "TodoTelescope",
    "TodoQuickFix",
    "TodoLocList",
  },

  init = function()
    vim.keymap.set("n", "<space>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo Trouble" })
    vim.keymap.set("n", "<space>xT", "<cmd>TodoTelescope<cr>", { desc = "Todo Telescope" })

    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })
  end,

  config = function()
    require("todo-comments").setup()
  end,
}
