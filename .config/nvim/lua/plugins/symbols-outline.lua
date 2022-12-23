return {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
  init = function()
    vim.keymap.set("n", "<space>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
  end,
  config = function()
    require("symbols-outline").setup()
  end,
}
