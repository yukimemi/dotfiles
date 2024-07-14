-- =============================================================================
-- File        : nvim-lsp-endhints.lua
-- Author      : yukimemi
-- Last Change : 2024/07/14 21:57:24.
-- =============================================================================

-- default settings
require("lsp-endhints").setup({
  icons = {
    type = "󰜁 ",
    parameter = "󰏪 ",
  },
  label = {
    padding = 1,
    marginLeft = 0,
    bracketedParameters = true,
  },
  autoEnableHints = true,
})
