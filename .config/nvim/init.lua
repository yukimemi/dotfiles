-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2023/10/25 21:48:06.
-- =============================================================================

if vim.loader then
  vim.loader.enable()
end

vim.env.BASE_DIR = vim.fn.stdpath("config") .. "/rc"

-- local dpp_base = vim.fn.stdpath("cache") .. "/dpp"
local dpp_base = vim.fn.expand("~/.cache/dpp")
local repos_dir = dpp_base .. "/repos/github.com/"

local dpp_config = vim.env.BASE_DIR .. "/dpp.ts"

local plugins = {
  "vim-denops/denops.vim",
  "Shougo/dpp.vim",
  "Shougo/dpp-ext-installer",
  "Shougo/dpp-ext-lazy",
  "Shougo/dpp-ext-local",
  "Shougo/dpp-ext-toml",
  "Shougo/dpp-protocol-git",
}
for _, plugin in ipairs(plugins) do
  vim.fn.system({ "git", "clone", "https://github.com/" .. plugin, repos_dir .. plugin })
  vim.opt.runtimepath:prepend(repos_dir .. plugin)
end

vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1

vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

vim.api.nvim_create_autocmd("User", {
  group = "MyAutoCmd",
  pattern = "DenopsReady",
  callback = function()
    vim.fn["dpp#make_state"](dpp_base, dpp_config)
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = "MyAutoCmd",
  pattern = "Dpp:makeStatePost",
  callback = function()
    vim.notify("[dpp] dpp#make_state is done")
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = "MyAutoCmd",
  pattern = "*.lua,*.vim,*.toml,*.ts",
  callback = function()
    vim.fn["dpp#check_files"]()
  end,
})

