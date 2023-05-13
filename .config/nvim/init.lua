vim.loader.enable()
-- local denops_src = vim.fn.stdpath("cache") .. "/denopm/repos/github.com/vim-denops/denops.vim"
local denops_src = vim.fn.expand("~/.cache/nvim/denopm/repos/github.com/vim-denops/denops.vim")
if not vim.loop.fs_stat(denops_src) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/vim-denops/denops.vim", denops_src })
end
vim.opt.runtimepath:prepend(denops_src)
