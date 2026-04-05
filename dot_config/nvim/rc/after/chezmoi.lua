-- =============================================================================
-- File        : chezmoi.lua
-- Author      : yukimemi
-- Last Change : 2026/04/05 23:36:26.
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

-- vim.keymap.set("n", "md", '<cmd>lua require("chezmoi.pick").snacks()<cr>', { desc = "Chezmoi files" })

require("chezmoi").setup({
  edit = {
    watch = true,
    force = false,
    ignore_patterns = {
      "run_onchange_.*",
      "run_once_.*",
      "%.chezmoiignore",
      "%.chezmoitemplate",
    },
  },
  events = {
    on_open = {
      notification = { enable = true },
    },
    on_watch = {
      notification = { enable = true },
    },
    on_apply = {
      notification = { enable = true },
    },
  },
})

vim.filetype.add({
  extension = {
    tmpl = function(path, _)
      local name = vim.fn.fnamemodify(path, ":t")
      local base = name:gsub("%.tmpl$", "")
      local ext = base:match("%.([^%.]+)$")
      if ext then
        return ext
      end
      return "gotexttmpl"
    end,
  },
})
