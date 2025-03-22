-- =============================================================================
-- File        : blink.pairs.lua
-- Author      : yukimemi
-- Last Change : 2025/03/15 20:20:41.
-- =============================================================================

require("blink.pairs").setup({
  highlights = {
    'RainbowOrange',
    'RainbowPurple',
    'RainbowBlue',
  },
  priority = 200,
  ns = vim.api.nvim_create_namespace('blink.pairs'),
  debug = false,
})
