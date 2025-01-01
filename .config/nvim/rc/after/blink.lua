-- =============================================================================
-- File        : blink.lua
-- Author      : yukimemi
-- Last Change : 2025/01/01 20:55:48.
-- =============================================================================

require("blink-cmp").setup({
  keymap = {
    preset = "default",
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<C-k>'] = { 'snippet_forward', 'fallback' },
    ['<C-j>'] = { 'snippet_backward', 'fallback' },
    cmdline = {
      preset = "none",
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
    ghost_text = { enabled = false },
  },
  signature = {
    enabled = true,
    window = { border = 'single' },
  },
})
