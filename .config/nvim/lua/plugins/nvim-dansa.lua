return {
  "hrsh7th/nvim-dansa",

  enabled = vim.g.plugin_use_dansa,

  event = "BufReadPre",

  config = function()
    local dansa = require("dansa")

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

    -- per filetype settings.
    dansa.setup.filetype("go", {
      default = {
        expandtab = false,
        tab = {
          shiftwidth = 4,
        }
      }
    })

    dansa.setup.filetype("xml", {
      default = {
        expandtab = false,
        space = {
          shiftwidth = 4,
        },
      },
    })
  end,
}
