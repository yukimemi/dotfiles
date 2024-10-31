-- =============================================================================
-- File        : blink.lua
-- Author      : yukimemi
-- Last Change : 2024/10/30 11:05:26.
-- =============================================================================

require("blink-cmp").setup({
  keymap = "default",

  trigger = {
    signature_help = {
      enabled = true,
    },
  },

  windows = {
    autocomplete = {
      border = "single",
      selection = "manual",
    },
    documentation = {
      border = "single",
      auto_show = true,
      auto_show_delay_ms = 500,
      update_delay_ms = 50,
    },
    signature_help = {
      border = "single",
    },
  },
})
