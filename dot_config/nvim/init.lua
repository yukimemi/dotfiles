-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2025/09/28 11:16:08.
-- =============================================================================

vim.loader.enable()
local denops = vim.fn.expand("~/.cache/nvim/dvpm/github.com/vim-denops/denops.vim")
if not vim.uv.fs_stat(denops) then
  vim.fn.system({ "git", "clone", "https://github.com/vim-denops/denops.vim", denops })
end
vim.opt.runtimepath:prepend(denops)
