-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2026/04/24 09:28:55.
-- =============================================================================

vim.g.ahdr_debug = false
vim.g.ahdr_cfg_path = "~/.config/ahdr/ahdr.toml"

vim.api.nvim_create_user_command("DenopsAhdrDebug", function()
  local group = vim.api.nvim_create_augroup("MyAhdr", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    buffer = 0, -- <buffer>
    command = "DenopsAhdr waitcmd",
  })
end, {})

vim.api.nvim_create_user_command("DenopsAhdrPwshDebug", function()
  local group = vim.api.nvim_create_augroup("MyAhdr", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    buffer = 0, -- <buffer>
    command = "DenopsAhdr waitcmdpwsh",
  })
end, {})
