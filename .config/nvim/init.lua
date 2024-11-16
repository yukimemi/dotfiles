-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2024/11/10 14:59:40.
-- =============================================================================

if vim.loader then
  vim.loader.enable()
end

local dvpm_cache = vim.fn.expand("~/.cache/nvim/dvpm/cache")
vim.opt.runtimepath:append(dvpm_cache)

local denops = vim.fn.expand("~/.cache/nvim/dvpm/github.com/vim-denops/denops.vim")
if not vim.uv.fs_stat(denops) then
  vim.fn.system({ "git", "clone", "https://github.com/vim-denops/denops.vim", denops })
end
vim.opt.runtimepath:prepend(denops)
