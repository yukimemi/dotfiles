return {
  "aznhe21/actions-preview.nvim",

  enabled = not vim.g.plugin_use_coc,

  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
  },

  keys = {
    {
      "<space>ca",
      function()
        require("actions-preview").code_actions()
      end,
      mode = { "n", "v" },
      desc = "Code action",
    },
  },
}
