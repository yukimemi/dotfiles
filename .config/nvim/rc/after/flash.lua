-- =============================================================================
-- File        : flash.lua
-- Author      : yukimemi
-- Last Change : 2025/11/02 21:51:54.
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
      enabled = true,
    },
    char = {
      enabled = false,
      multi_line = false,
    },
  },
})

vim.keymap.set("n", "ss", function() require("flash").jump() end, { desc = "Flash" })
