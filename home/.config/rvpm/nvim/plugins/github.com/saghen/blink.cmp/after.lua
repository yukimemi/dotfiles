-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:10:06.
-- =============================================================================

require("blink.compat").setup()

require("blink.cmp").setup({
  keymap = {
    ['<C-f>'] = { 'hide', 'fallback' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<S-Tab>'] = false,
  },
  sources = {
    default = { 'lsp', 'buffer', 'path', 'ripgrep' },
    per_filetype = {
      markdown = { inherit_defaults = true, 'obsidian' },
    },
    providers = {
      obsidian = {
        name = "obsidian",
        module = "blink.compat.source",
      },
      ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
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
  },
  signature = {
    enabled = true,
    window = { border = 'single' },
  },
  cmdline = {
    keymap = {
      ['<C-n>'] = { 'fallback_to_mappings' },
      ['<C-p>'] = { 'fallback_to_mappings' },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
      menu = {
        auto_show = true,
      },
    },
  },
})
