-- =============================================================================
-- File        : neocodeium.lua
-- Author      : yukimemi
-- Last Change : 2024/12/08 17:00:37.
-- =============================================================================

local neocodeium = require("neocodeium")
neocodeium.setup()

vim.keymap.set("i", "<c-e>", function()
  neocodeium.accept()
end)
vim.keymap.set("i", "<c-f>", function()
  neocodeium.accept_word()
end)
vim.keymap.set("i", "<c-j>", function()
  neocodeium.cycle(1)
end)
vim.keymap.set("i", "<c-k>", function()
  neocodeium.cycle(-1)
end)
