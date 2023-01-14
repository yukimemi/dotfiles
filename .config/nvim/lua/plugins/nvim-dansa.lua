return {
  "hrsh7th/nvim-dansa",

  enabled = vim.g.plugin_use_dansa,

  event = "BufReadPre",

  config = function()
    local dansa = require("dansa")

    -- global settings.
    dansa.setup({
      -- The threshold for how much to scan above and below the cursor line
      threshold = 100,

      -- The settings for tab-indentation or when it cannot be guessed.
      default = {
        expandtab = false,
        space = {
          shiftwidth = 2,
        },
        tab = {
          shifwidth = 4,
        }
      }
    })

    -- per filetype settings.
    dansa.setup.filetype("go", {
      default = {
        expandtab = true,
        tab = {
          shifwidth = 4,
        },
      },
    })

    dansa.setup.filetype("xml", {
      default = {
        expandtab = false,
        space = {
          shiftwidth = 2,
        },
      },
    })
  end,
}
