-- =============================================================================
-- File        : treemonkey.lua
-- Author      : yukimemi
-- Last Change : 2024/01/06 01:35:02.
-- =============================================================================

vim.keymap.set({ "x", "o" }, "m", function()
  require("treemonkey").select({
    ignore_injections = false,
    highlight = { backdrop = "Comment" }
  })
end)
