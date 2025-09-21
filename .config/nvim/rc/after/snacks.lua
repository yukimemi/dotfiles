-- =============================================================================
-- File        : snacks.lua
-- Author      : yukimemi
-- Last Change : 2025/09/20 11:28:14.
-- =============================================================================

require("snacks").setup({
  animate = {
    enabled = false,
  },
  bufdelete = {
    enabled = false,
  },
  bigfile = {
    enabled = true,
  },
  dashboard = {
    enabled = false,
  },
  debug = {
    enabled = true,
  },
  input = {
    enabled = true,
  },
  notifier = {
    enabled = true,
    width = { min = 40, max = 0.9 },
  },
  notify = {
    enabled = true,
  },
  quickfile = {
    enabled = false,
  },
  indent = {
    enabled = true,
  },
  lazygit = {
    enabled = true,
  },
  scope = {
    enabled = true,
  },
  scroll = {
    enabled = true,
  },
  statuscolumn = {
    enabled = true,
  },
  words = {
    enabled = true,
  },
  terminal = {
    enabled = false,
  },
  git = {
    enabled = false,
  },
  picker = {
    enabled = true,
  },
})

-- Snacks.debug
_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end
if vim.fn.has("nvim-0.11") == 1 then
  vim._print = function(_, ...)
    dd(...)
  end
else
  vim.print = dd
end

-- Snacks.jump
vim.keymap.set("n", "<space>jj", function() Snacks.words.jump(1, true) end, { desc = "Jump next" })
vim.keymap.set("n", "<space>jk", function() Snacks.words.jump(-1, true) end, { desc = "Jump prev" })

-- Snacks.lazygit
vim.keymap.set("n", "<space>gg", function() Snacks.lazygit() end, { desc = "LazyGit" })

-- Snacks.bufdelete
-- vim.keymap.set("n", "sbd", function() Snacks.bufdelete() end, { desc = "Delete buffer" })

-- Snacks.notifier
vim.keymap.set("n", "<space>nl", function() Snacks.notifier.show_history() end, { desc = "Snacks history" })

if true then
  vim.keymap.set("n", "<space>S", function() Snacks.picker() end, { desc = "Snacks picker" })
  vim.keymap.set("n", "<space>ff", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
  vim.keymap.set("n", "<space>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
  vim.keymap.set("n", "<space>/", function() Snacks.picker.grep() end, { desc = "Grep" })
  vim.keymap.set("n", "<space>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
  vim.keymap.set("n", "<space>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
  vim.keymap.set("n", "<space>e", function() Snacks.explorer() end, { desc = "File Explorer" })

  vim.keymap.set("n", "mg", function() Snacks.picker.git_files() end, { desc = "Find git files" })
  vim.keymap.set("n", "mc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Find Config File" })
  vim.keymap.set("n", "md", function() Snacks.picker.git_files({ cwd = "~/.dotfiles" }) end,
    { desc = "Find dotfiles" })
  vim.keymap.set("n", "ms", function() Snacks.picker.files({ cwd = "~/src" }) end,
    { desc = "Find src file" })
  vim.keymap.set("n", "mr", function() Snacks.picker.recent() end, { desc = "Recent files" })
  vim.keymap.set("n", "mC", function() Snacks.picker.files({ cwd = "~/.cache" }) end,
    { desc = "Find Cache File" })
  vim.keymap.set("n", "mM", function() Snacks.picker.files({ cwd = "~/.memolist" }) end, { desc = "Find memolist file" })
  vim.keymap.set("n", "mj", function() Snacks.picker.files({ cwd = "~/.cache/junkfile" }) end,
    { desc = "Find junk file" })
  vim.keymap.set("n", "mb", function()
    local bufname = vim.fn.bufname()
    local bufdir = vim.fn.fnamemodify(bufname, ":p:h")
    Snacks.picker.files({ cwd = bufdir })
  end, { desc = "Find file on buffer dir" })
  vim.keymap.set("n", "<space>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
  vim.keymap.set("n", "<space>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
  vim.keymap.set("n", "<space>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
  vim.keymap.set({ "n", "x" }, "<space>sw", function() Snacks.picker.grep_word() end,
    { desc = "Visual selection or word" })

  vim.keymap.set("n", "<space>hh", function() Snacks.picker.help() end, { desc = "Help Pages" })
  vim.keymap.set("n", "<space>hk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })

  vim.keymap.set("n", "<space>sr", function() Snacks.picker.resume() end, { desc = "Resume" })
  vim.keymap.set("n", "<space>pp", function() Snacks.picker.projects() end, { desc = "Projects" })

  -- lsp
  -- vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "LSP definitions" })
  -- vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "LSP implementations" })
  -- vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "LSP references" })
  -- vim.keymap.set("n", "gt", function() Snacks.picker.lsp_type_definitions() end, { desc = "LSP type definitions" })
  -- vim.keymap.set("n", "gs", function() Snacks.picker.lsp_symbols() end, { desc = "LSP symbols" })

  -- git
  vim.keymap.set("n", "<space>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
  vim.keymap.set("n", "<space>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
  -- vim.keymap.set("n", "<space>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
  vim.keymap.set("n", "<space>gS", function() Snacks.picker.git_status() end, { desc = "Git Status" })
  -- vim.keymap.set("n", "<space>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
  vim.keymap.set("n", "<space>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
  vim.keymap.set("n", "<space>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
end
