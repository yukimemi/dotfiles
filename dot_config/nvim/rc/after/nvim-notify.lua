-- =============================================================================
-- File        : nvim-notify.lua
-- Author      : yukimemi
-- Last Change : 2023/12/04 01:33:00.
-- =============================================================================

require("notify").setup({
  render = "compact",
  stages = "slide",
})
vim.notify = require("notify")
