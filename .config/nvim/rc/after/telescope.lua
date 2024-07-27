-- =============================================================================
-- File        : telescope.lua
-- Author      : yukimemi
-- Last Change : 2024/07/27 22:06:00.
-- =============================================================================

local telescope = require("telescope")
local borderless = false

telescope.setup({
  defaults = {
    layout_strategy = "vertical",
    mappings = {
      i = {
        ["<C-Down>"] = require("telescope.actions").cycle_history_next,
        ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
      },
    },
    prompt_prefix = " ",
    selection_caret = " ",
    winblend = borderless and 0 or 10,
  },
  extensions = {
    project = {
      base_dirs = {
        { "~/src", max_depth = 4 },
      },
    },
  },
})
