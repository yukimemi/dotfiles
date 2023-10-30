-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2023/10/30 23:01:03.
-- =============================================================================

if vim.loader then
  vim.loader.enable()
end

vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

if vim.v.vim_did_enter == 0 then
  local startuptime = vim.fn.reltime()
  vim.api.nvim_create_autocmd("VimEnter", {
    group = "MyAutoCmd",
    pattern = "*",
    once = true,
    callback = function()
      startuptime = vim.fn.reltime(startuptime)
      vim.cmd("redraw")
      vim.notify("startuptime: " .. vim.fn.reltimestr(startuptime))
    end,
  })
end

vim.cmd[[runtime! rc/dpp.vim]]

