-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/05/31 14:40:31.
-- =============================================================================

require("silentsaver").setup({
  diff_vertical = true,
  events = { "CursorHold", "BufWritePre" },
  ignore_filetypes = {
    "NvimTree", "TelescopePrompt", "aerial", "asyncwalker", "asyncwalker-filter",
    "coc-explorer", "csv", "ctrlp", "ddu", "ddu-ff", "ddu-ff-filter", "ddu-filer",
    "deck", "fall-help", "fall-input", "fall-list", "gin-diff", "gin-status",
    "gundo", "list", "log", "neo-tree", "qf", "quickfix", "undotree",
  },
  -- Optional: cap version history (defaults to unlimited, as the denops version was).
  -- retention = { max_per_file = 200, max_age_days = 90 },
})
