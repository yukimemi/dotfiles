return {
  "aznhe21/actions-preview.nvim",

  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
  },

  keys = {
    { "<space>ca", function() require("actions-preview").code_actions() end, mode = { "n", "v" } },
  },
}
