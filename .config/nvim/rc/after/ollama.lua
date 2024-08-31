-- =============================================================================
-- File        : ollama.lua
-- Author      : yukimemi
-- Last Change : 2024/08/31 17:17:49.
-- =============================================================================

require("ollama").setup()

vim.keymap.set({ "n", "v" }, "<leader>oo", "<cmd>lua require('ollama').prompt()<cr>", { desc = "ollama prompt" })
vim.keymap.set(
  { "n", "v" },
  "<leader>oG",
  "<cmd>lua require('ollama').prompt('Generate_Code')<cr>",
  { desc = "ollama Generate_Code" }
)
