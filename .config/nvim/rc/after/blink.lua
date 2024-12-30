-- =============================================================================
-- File        : blink.lua
-- Author      : yukimemi
-- Last Change : 2024/12/30 15:37:40.
-- =============================================================================

require("blink-cmp").setup({
  keymap = {
    preset = "default",
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<C-k>'] = { 'snippet_forward', 'fallback' },
    ['<C-j>'] = { 'snippet_backward', 'fallback' },
    cmdline = {
      preset = "enter",
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
    },
  },
  completion = {
    list = {
      selection = function(ctx)
        return ctx.mode == 'cmdline' and 'manual' or 'manual'
      end
    },
    menu = { border = 'single' },
    documentation = { window = { border = 'single' } },
  },
  signature = {
    enabled = true,
    window = { border = 'single' },
  },
})
