-- =============================================================================
-- File        : smart-motion.lua
-- Author      : yukimemi
-- Last Change : 2026/02/08 17:03:13.
-- =============================================================================

require("smart-motion").setup({
  presets = {
    words = true,
    lines = true,
    search = true,
    delete = true,
    yank = true,
    change = true,
    paste = true,
    treesitter = true,
    diagnostics = true,
    git = true,
    quickfix = true,
    marks = true,
    misc = true,
  },
})
