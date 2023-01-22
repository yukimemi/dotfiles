return {
  "uga-rosa/contextment.vim",

  enabled = false,

  dependencies = {
    "Shougo/context_filetype.vim"
  },

  keys = {
    { "gc", "<Plug>(contextment)", mode = "x" },
    { "gcc", "<Plug>(contextment-line)", mode = "n" },
  },
}
