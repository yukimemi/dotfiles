return {
  "nvim-neo-tree/neo-tree.nvim",

  enabled = vim.g.plugin_use_neotree,

  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      config = function()
        require("window-picker").setup()
      end
    },
  },

  cmd = "Neotree",

  keys = {
    { "ge", "<cmd>Neotree reveal_force_cwd<cr>", mode = "n" },
    { "gE",
      function() vim.cmd(string.format("Neotree reveal_force_cwd reveal_file=%s",
          vim.fn.expand("%:p")))
      end, mode = "n" },
  },

  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
  end,

  config = function()
    require("neo-tree").setup({
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      },
    })
  end,
}
