-- =============================================================================
-- File        : chezmoi.lua
-- Author      : yukimemi
-- Last Change : 2026/01/25 21:47:03.
-- =============================================================================

local group = vim.api.nvim_create_augroup("chezmoi_auto_watch", { clear = true })
local pattern = vim.fn.expand("~") .. "/.local/share/chezmoi/*"
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { pattern },
  callback = function(ev)
    local bufnr = ev.buf
    local edit_watch = function()
      local ok, edit = pcall(require, "chezmoi.commands.__edit")
      if ok then
        edit.watch(bufnr)
      end
    end
    vim.schedule(edit_watch)
  end,
})

