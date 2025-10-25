-- =============================================================================
-- File        : flash.lua
-- Author      : yukimemi
-- Last Change : 2025/10/25 23:42:31.
-- =============================================================================

require("flash").setup({
  search = {
    mode = "search",
    incremental = true,
  },
  label = {
    rainbow = {
      enabled = true,
    },
  },
  modes = {
    search = {
      enabled = true,
    },
    char = {
      enabled = false,
      multi_line = false,
    },
  },
})

vim.keymap.set("n", "ss", function() require("flash").jump() end, { desc = "Flash" })
