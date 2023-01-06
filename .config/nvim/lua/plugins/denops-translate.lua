return {
  "skanehira/denops-translate.vim",

  enabled = false,

  lazy = false,

  init = function()
    vim.keymap.set({ "n", "x" }, "<space>e", "<Plug>(Translate)", { desc = "Translate" })
  end,

  dependencies = {
    "vim-denops/denops.vim",
  },
}
