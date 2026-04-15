-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2026/04/13 00:00:00.
-- =============================================================================

vim.loader.enable()
local loader = vim.fn.expand("~/.cache/rvpm/nvim/plugins/loader.lua")
if vim.uv.fs_stat(loader) then
  dofile(loader)
end
