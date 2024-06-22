-- =============================================================================
-- File        : telescope.lua
-- Author      : yukimemi
-- Last Change : 2024/06/09 20:42:36.
-- =============================================================================

local actions = require("telescope.actions")

local telescope = require("telescope")
local borderless = false

telescope.setup({
  defaults = {
    layout_strategy = "horizontal",
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
