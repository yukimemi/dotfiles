-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/05/31 12:22:41.
-- =============================================================================

require("lumiris").setup({
  notify = true,
  interval = 600,
  background = "dark",
  -- Enumerate lazily-installed colorschemes from rvpm's clone cache.
  -- Loading on apply is delegated to rvpm's ColorSchemePre hook.
  colors_path = { vim.fn.expand("~/.cache/rvpm/nvim/plugins/repos") },
})

