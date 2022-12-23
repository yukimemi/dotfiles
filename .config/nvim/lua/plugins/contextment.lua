return {
  "uga-rosa/contextment.vim",

  enabled = false,

  dependencies = {
    "Shougo/context_filetype.vim"
  },

  keys = {"gc", "gcc"},

  init = function()
    vim.keymap.set({"n", "x"}, "gc", "<Plug>(contextment)")
    vim.keymap.set("n", "gcc", "<Plug>(contextment-line)")
  end,
}
