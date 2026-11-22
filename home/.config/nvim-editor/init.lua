vim.loader.enable()
local loader = vim.fn.expand("~/.cache/rvpm/nvim-editor/plugins/loader.lua")
if vim.uv.fs_stat(loader) then
  dofile(loader)
end
