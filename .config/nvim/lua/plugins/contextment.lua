return {
  "uga-rosa/contextment.vim",

  enabled = vim.g.plugin_use_contextment,

  dependencies = {
    "Shougo/context_filetype.vim",
  },

  keys = {
    { "gcc", "<Plug>(contextment)", mode = "x" },
    { "gcc", "<Plug>(contextment-line)", mode = "n" },
  },
}
