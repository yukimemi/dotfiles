-- =============================================================================
-- File        : slimline.lua
-- Author      : yukimemi
-- Last Change : 2025/09/07 12:04:06.
-- =============================================================================

vim.o.laststatus = 3

require("slimline").setup({
  style = 'fg',
  bold = true,
  components = {
    center = {
      function(active)
        return Slimline.highlights.hl_component(
          { primary = vim.g.colors_name, secondary = vim.g.lumiris_priority },
          Slimline.highlights.hls.components['path'],
          Slimline.get_sep('path'),
          'right',
          active,
          'fg'
        )
      end,
      function()
        return vim.bo.bomb and "💣" or ""
      end,
    },
  },
  -- pure
  configs = {
    path = {
      hl = {
        primary = 'Label',
      },
    },
    git = {
      hl = {
        primary = 'Function',
      },
    },
    filetype_lsp = {
      hl = {
        primary = 'String',
      },
    },
  },
})
