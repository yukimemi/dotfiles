-- =============================================================================
-- File        : smart-motion.lua
-- Author      : yukimemi
-- Last Change : 2026/02/08 17:22:06.
-- =============================================================================

require("smart-motion").setup({
  presets = {
    words = false,
    lines = false,
    search = {
      s = false,
      f = false,
      F = false,
      t = false,
      T = false,
    },
    delete = true,
    yank = true,
    change = true,
    paste = true,
    treesitter = true,
    diagnostics = true,
    git = true,
    quickfix = true,
    marks = true,
    misc = false,
  },
})
