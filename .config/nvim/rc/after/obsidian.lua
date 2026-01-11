-- =============================================================================
-- File        : obsidian.lua
-- Author      : yukimemi
-- Last Change : 2026/01/11 17:24:34
-- =============================================================================

local source = require("obsidian")
source.setup({
  workspaces = {
    {
      name = "personal",
      path = "~/obsidian",
    },
  },
  completion = {
    nvim_cmp = false,
    min_chars = 2,
  },
})
