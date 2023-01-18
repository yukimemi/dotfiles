return {
  "nvim-neo-tree/neo-tree.nvim",

  enabled = vim.g.plugin_use_neotree,

  dependencies = {
    "MunifTanjim/nui.nvim",
  },

  cmd = "Neotree",

  keys = {
    { "ge", "<cmd>Neotree<cr>", mode = "n" },
  },

  config = function()
    vim.g.neo_tree_remove_legacy_commands = 1

    require("neo-tree").setup({
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      },
    })
  end,
}
