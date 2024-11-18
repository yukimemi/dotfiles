-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2024/11/18 22:03:56.
-- =============================================================================

if vim.loader then
  vim.loader.enable()
end

local denops = vim.fn.expand("~/.cache/nvim/dvpm/github.com/vim-denops/denops.vim")
if not vim.uv.fs_stat(denops) then
  vim.fn.system({ "git", "clone", "https://github.com/vim-denops/denops.vim", denops })
end
vim.opt.runtimepath:prepend(denops)
