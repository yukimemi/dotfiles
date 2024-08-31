-- =============================================================================
-- File        : neocodeium.lua
-- Author      : yukimemi
-- Last Change : 2024/08/31 17:54:45.
-- =============================================================================

require("neocodeium").setup()

vim.keymap.set("i", "<c-e>", function()
  require("neocodeium").accept()
end)
vim.keymap.set("i", "<c-f>", function()
  require("neocodeium").accept_word()
end)
vim.keymap.set("i", "<c-j>", function()
  pcall(require("cmp").abort)
  require("neocodeium").cycle(1)
end)
vim.keymap.set("i", "<c-k>", function()
  pcall(require("cmp").abort)
  require("neocodeium").cycle(-1)
end)
