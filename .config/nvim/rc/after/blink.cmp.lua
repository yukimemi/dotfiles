-- =============================================================================
-- File        : blink.cmp.lua
-- Author      : yukimemi
-- Last Change : 2025/03/16 02:05:54.
-- =============================================================================

require("blink-cmp").setup({
  keymap = {
    preset = "default",
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<C-k>'] = { 'snippet_forward', 'fallback' },
    ['<C-j>'] = { 'snippet_backward', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-n>'] = { 'select_next', 'fallback' },
  },
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
    }
  },
  term = {
    enabled = false,
  },
  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    menu = { border = 'single' },
    documentation = {
      auto_show = true,
      window = { border = 'single' }
    },
    ghost_text = { enabled = false },
  },
  signature = {
    enabled = true,
    window = { border = 'single' },
  },
})
