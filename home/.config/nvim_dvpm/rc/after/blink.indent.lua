-- =============================================================================
-- File        : blink.indent.lua
-- Author      : yukimemi
-- Last Change : 2025/10/04 08:37:24
-- =============================================================================

require("blink.indent").setup({
  static = {
    enabled = true,
    highlights = { 'BlinkIndent' },
  },
  scope = {
    enabled = true,
    highlights = {
      'BlinkIndentOrange',
      'BlinkIndentViolet',
      'BlinkIndentBlue',
      'BlinkIndentRed',
      'BlinkIndentCyan',
      'BlinkIndentYellow',
      'BlinkIndentGreen',
    },
    underline = {
      enabled = true,
      highlights = {
        'BlinkIndentOrangeUnderline',
        'BlinkIndentVioletUnderline',
        'BlinkIndentBlueUnderline',
        'BlinkIndentRedUnderline',
        'BlinkIndentCyanUnderline',
        'BlinkIndentYellowUnderline',
        'BlinkIndentGreenUnderline',
      },
    },
  },
})
