-- =============================================================================
-- File        : nvim-scissors.lua
-- Author      : yukimemi
-- Last Change : 2025/12/07 21:47:54
-- =============================================================================

vim.keymap.set(
  "n",
  "<leader>se",
  function() require("scissors").editSnippet() end,
  { desc = "Snippet: Edit" }
)

-- when used in visual mode, prefills the selection as snippet body
vim.keymap.set(
  { "n", "x" },
  "<leader>sa",
  function() require("scissors").addNewSnippet() end,
  { desc = "Snippet: Add" }
)

require("scissors").setup {
  snippetDir = vim.fn.stdpath("config") .. "/snippets",
}
