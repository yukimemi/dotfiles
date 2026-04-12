-- =============================================================================
-- File        : jab.lua
-- Author      : yukimemi
-- Last Change : 2025/03/02 15:26:17.
-- =============================================================================

-- incremental search
-- if vim-kensaku is available and initial query is uppercase,
-- then the search is case-sensitive.
-- Otherwise, the search is case-insensitive.
-- hints appear on the left of the matches if possible.
vim.keymap.set({ "n", "x", "o" }, "ss", function()
  return require("jab").jab_win()
end, { expr = true })

-- f-motions
-- search is always case-sensitive
-- hints appear exactly on the matches.
-- vim.keymap.set({ "n", "x", "o" }, "f", function()
--   return require("jab").f()
-- end, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "F", function()
--   return require("jab").F()
-- end, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "t", function()
--   return require("jab").t()
-- end, { expr = true })
-- vim.keymap.set({ "n", "x", "o" }, "T", function()
--   return require("jab").T()
-- end, { expr = true })
