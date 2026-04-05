-- =============================================================================
-- File        : chezmoi.lua
-- Author      : yukimemi
-- Last Change : 2026/02/01 11:17:53.
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

-- Force set filetype of .tmpl files using Neovim's built-in detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = pattern .. "*.tmpl",
  callback = function(ev)
    local ft = vim.filetype.match({ filename = ev.match:gsub("%.tmpl$", "") })
    if ft then
      vim.bo[ev.buf].filetype = ft
    end
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
