-- =============================================================================
-- File        : which-key.lua
-- Author      : yukimemi
-- Last Change : 2025/01/19 17:56:25.
-- =============================================================================

require("which-key").setup({})

vim.keymap.set("n", "<space>?", function()
  require("which-key").show({ global = false })
end, { desc = "Show local mappings" })
