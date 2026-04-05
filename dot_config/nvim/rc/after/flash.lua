-- =============================================================================
-- File        : flash.lua
-- Author      : yukimemi
-- Last Change : 2026/04/05 22:38:11.
-- =============================================================================

require("flash").setup({
  search = {
    mode = "exact",
    incremental = false,
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
      char_actions = function(motion)
        return {
          [motion:lower()] = "next",
          [motion:upper()] = "prev",
        }
      end,
    },
  },
})

vim.keymap.set("n", "ss", function() require("flash").jump() end, { desc = "Flash" })
