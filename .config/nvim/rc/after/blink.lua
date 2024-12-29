-- =============================================================================
-- File        : blink.lua
-- Author      : yukimemi
-- Last Change : 2024/12/29 17:44:10.
-- =============================================================================

require("blink-cmp").setup({
  keymap = {
    preset = "default",
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<C-k>'] = { 'snippet_forward', 'fallback' },
    ['<C-j>'] = { 'snippet_backward', 'fallback' },
  },
  completion = {
    menu = { border = 'single' },
    documentation = { window = { border = 'single' } },
  },
  signature = {
    enabled = true,
    window = { border = 'single' },
  },
})
