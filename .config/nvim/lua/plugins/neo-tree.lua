return {
  "nvim-neo-tree/neo-tree.nvim",

  dependencies = {
    "MunifTanjim/nui.nvim",
  },

  cmd = "Neotree",
  init = function()
    vim.keymap.set("n", "ge", "<cmd>Neotree<cr>")
  end,
  config = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require("neo-tree").setup({
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      },
    })
  end,
}
