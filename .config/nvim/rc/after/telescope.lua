local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")
local borderless = false

telescope.setup({
  defaults = {
    layout_strategy = "horizontal",
    mappings = {
      i = {
        ["<c-t>"] = trouble.open_with_trouble,
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
