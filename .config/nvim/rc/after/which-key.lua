-- =============================================================================
-- File        : which-key.lua
-- Author      : yukimemi
-- Last Change : 2026/01/11 10:06:26.
-- =============================================================================

require("which-key").setup({
  triggers = {
    { "<auto>", mode = "nixsotc" },
    { "m",      mode = { "n" } },
  }
})

vim.keymap.set("n", "<space>?", function()
  require("which-key").show({ global = false })
end, { desc = "Show local mappings" })
