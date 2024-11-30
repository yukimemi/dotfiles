-- =============================================================================
-- File        : blink.lua
-- Author      : yukimemi
-- Last Change : 2024/11/26 20:55:41.
-- =============================================================================

require("blink-cmp").setup({
  keymap = {
    preset = "default",
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<C-k>'] = { 'snippet_forward', 'fallback' },
    ['<C-j>'] = { 'snippet_backward', 'fallback' },
  },

  trigger = {
    signature_help = {
      enabled = true,
    },
  },

  fuzzy = {
    prebuilt_binaries = {
      download = true,
      force_version = "v0.6.1",
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
    },
    signature_help = {
      border = "single",
    },
  },
})
