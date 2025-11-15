-- =============================================================================
-- File        : flash.lua
-- Author      : yukimemi
-- Last Change : 2025/11/15 18:22:12.
-- =============================================================================

require("flash").setup({
  search = {
    mode = "exact",
    incremental = true,
  },
  label = {
    rainbow = {
      enabled = true,
    },
  },
  modes = {
    search = {
      enabled = false,
    },
    char = {
      enabled = false,
      multi_line = false,
    },
  },
})

vim.keymap.set("n", "ss", function() require("flash").jump() end, { desc = "Flash" })
