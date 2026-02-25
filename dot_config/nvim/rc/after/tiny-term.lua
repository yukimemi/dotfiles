-- =============================================================================
-- File        : tiny-term.lua
-- Author      : yukimemi
-- Last Change : 2026/02/25 23:58:35
-- =============================================================================

require("tiny-term").setup({
  override_snacks = false,
})

vim.keymap.set("n", "<c-/>", function()
  require("tiny-term").toggle("pwsh")
end, { desc = "Toggle Terminal" })
