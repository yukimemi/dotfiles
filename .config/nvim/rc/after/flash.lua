-- =============================================================================
-- File        : flash.lua
-- Author      : yukimemi
-- Last Change : 2025/01/14 01:09:33.
-- =============================================================================

require("flash").setup({
  search = {
    mode = "search",
    incremental = false,
  },
  label = {
    rainbow = {
      enabled = true,
    },
  },
  modes = {
    char = {
      enabled = true,
      multi_line = false,
    },
  },
})

vim.keymap.set("n", "ss", function() require("flash").jump() end, { desc = "Flash" })

