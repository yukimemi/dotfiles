-- =============================================================================
-- File        : indent-blankline.vim
-- Author      : yukimemi
-- Last Change : 2024/10/15 23:38:37.
-- =============================================================================

local highlight = {
  "RainbowDelimiterRed",
  "RainbowDelimiterYellow",
  "RainbowDelimiterBlue",
  "RainbowDelimiterOrange",
  "RainbowDelimiterGreen",
  "RainbowDelimiterViolet",
  "RainbowDelimiterCyan",
}
vim.g.rainbow_delimiters = { highlight = highlight }

require "ibl".setup({
  indent = {
    char = "▏",
  },
  scope = {
    highlight = highlight,
  },
})

local hooks = require("ibl.hooks")
hooks.register(
  hooks.type.SCOPE_HIGHLIGHT,
  hooks.builtin.scope_highlight_from_extmark
)
