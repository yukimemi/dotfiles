-- =============================================================================
-- File        : flash.lua
-- Author      : yukimemi
-- Last Change : 2025/02/10 19:35:38.
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
      enabled = false,
      multi_line = false,
    },
  },
})

vim.keymap.set("n", "ss", function() require("flash").jump() end, { desc = "Flash" })

