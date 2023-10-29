-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2023/10/30 00:04:59.
-- =============================================================================

if vim.loader then
  vim.loader.enable()
end

-- vim.env.BASE_DIR = vim.fn.stdpath("config") .. "/rc"
-- local dpp_base = vim.fn.expand("~/.cache/dpp")
-- local repos_dir = dpp_base .. "/repos/github.com/"
-- local dpp_config = vim.env.BASE_DIR .. "/dpp.ts"
--
-- local plugins = {
--   "vim-denops/denops.vim",
--   "Shougo/dpp.vim",
--   "Shougo/dpp-ext-installer",
--   "Shougo/dpp-ext-lazy",
--   "Shougo/dpp-ext-local",
--   "Shougo/dpp-ext-toml",
--   "Shougo/dpp-protocol-git",
-- }
-- for _, plugin in ipairs(plugins) do
--   vim.fn.system({ "git", "clone", "https://github.com/" .. plugin, repos_dir .. plugin })
--   vim.opt.runtimepath:prepend(repos_dir .. plugin)
-- end

vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

-- if vim.fn["dpp#min#load_state"](dpp_base) > 0 then
--   vim.api.nvim_create_autocmd("User", {
--     group = "MyAutoCmd",
--     pattern = "DenopsReady",
--     callback = function()
--       vim.fn["dpp#make_state"](dpp_base, dpp_config)
--     end,
--   })
--
--   vim.api.nvim_create_autocmd("User", {
--     group = "MyAutoCmd",
--     pattern = "Dpp:makeStatePost",
--     callback = function()
--       vim.notify("[dpp] dpp#make_state is done")
--     end,
--   })
-- else
--   vim.api.nvim_create_autocmd("BufWritePost", {
--     group = "MyAutoCmd",
--     pattern = "*.lua,*.vim,*.toml,*.ts",
--     callback = function()
--       vim.fn["dpp#check_files"]()
--     end,
--   })
-- end

vim.cmd[[runtime! rc/dpp.vim]]

