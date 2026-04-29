-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:10:06.
-- =============================================================================

require("blink-cmp").setup({
  keymap = {
    preset = "default",
    ['<C-f>'] = { 'hide', 'fallback' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<C-k>'] = { 'snippet_forward', 'fallback' },
    ['<C-j>'] = { 'snippet_backward', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
  },
  sources = {
    default = { 'lsp', 'buffer', 'snippets', 'path', 'ripgrep', 'obsidian' },
    providers = {
      obsidian = {
        name = "obsidian",
        module = "blink.compat.source",
      },
      ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
        opts = {},
      },
    },
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
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
      ['<C-n>'] = { 'fallback_to_mappings' },
      ['<C-p>'] = { 'fallback_to_mappings' },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      menu = {
        auto_show = true,
      },
    },
  },
  term = {
    enabled = false,
  },
})
