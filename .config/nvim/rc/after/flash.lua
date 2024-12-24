-- =============================================================================
-- File        : flash.lua
-- Author      : yukimemi
-- Last Change : 2024/12/23 20:59:50.
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

