-- =============================================================================
-- File        : nvim-dansa.lua
-- Author      : yukimemi
-- Last Change : 2023/12/04 01:32:45.
-- =============================================================================

local dansa = require('dansa')

-- global settings.
dansa.setup({
  -- Specify enabled or disabled.
  enabled = true,

  -- The offset to specify how much lines to use.
  scan_offset = 100,

  -- The count for cut-off the indent candidate.
  cutoff_count = 5,

  -- The settings for tab-indentation or when it cannot be guessed.
  default = {
    expandtab = true,
    space = {
      shiftwidth = 2,
    },
    tab = {
      shiftwidth = 4,
    }
  }
})
