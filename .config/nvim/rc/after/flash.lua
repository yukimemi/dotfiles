-- =============================================================================
-- File        : flash.lua
-- Author      : yukimemi
-- Last Change : 2024/12/30 22:28:58.
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
})

vim.keymap.set("n", "ss", function() require("flash").jump() end, { desc = "Flash" })

