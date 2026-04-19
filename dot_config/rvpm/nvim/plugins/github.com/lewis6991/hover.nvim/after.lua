-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:10:06.
-- =============================================================================

require("hover").config({
  providers = {
    "hover.providers.lsp",
    "hover.providers.diagnostic",
    "hover.providers.man",
    "hover.providers.dictionary",
  },
  preview_opts = { border = "single" },
  preview_window = false,
  title = true,
  mouse_providers = { "hover.providers.lsp" },
  mouse_delay = 1000,
})

local function hover_is_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.w[win].hover_provider then
      return true
    end
  end
  return false
end

vim.keymap.set("n", "K", function()
  local hover = require("hover")
  if hover_is_open() then
    hover.enter()
  else
    hover.open()
  end
end, { desc = "hover.nvim (open/enter)" })

vim.keymap.set("n", "gK", function() require("hover").select() end, { desc = "hover.nvim (select)" })
-- vim.keymap.set("n", "<c-p>", function() require("hover").switch("previous") end, { desc = "hover.nvim (previous)" })
-- vim.keymap.set("n", "<c-n>", function() require("hover").switch("next") end, { desc = "hover.nvim (next)" })
