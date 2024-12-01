-- =============================================================================
-- File        : telescope.lua
-- Author      : yukimemi
-- Last Change : 2024/12/01 10:04:33.
-- =============================================================================

local telescope = require("telescope")
local borderless = true

telescope.setup({
  defaults = {
    layout_strategy = "vertical",
    mappings = {
      i = {
        ["<C-Down>"] = require("telescope.actions").cycle_history_next,
        ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
      },
    },
    prompt_prefix = " ",
    selection_caret = " ",
    winblend = borderless and 0 or 10,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
      "--no-ignore",
      "--glob",
      "!**/node_modules/**",
      "--glob",
      "!**/.git/**",
    }
  },
  extensions = {
    project = {
      base_dirs = {
        { "~/src", max_depth = 4 },
      },
    },
  },
})

--------------------------------------------------------------------------------
-- Prefix "f" (files) --
--------------------------------------------------------------------------------
vim.keymap.set("n", "<space>ff", "<cmd>Telescope<cr>", { desc = "Telescope" })

vim.keymap.set("n", "ms", function()
  require("telescope.builtin").find_files({ cwd = "~/src" })
end, { desc = "Find src file" })

vim.keymap.set("n", "mg", "<cmd>Telescope git_files<cr>", { desc = "Find git files" })

vim.keymap.set("n", "mb", function()
  local bufname = vim.fn.bufname()
  local bufdir = vim.fn.fnamemodify(bufname, ":p:h")
  require("telescope.builtin").find_files({ cwd = bufdir })
end, { desc = "Find file on buffer dir" })

vim.keymap.set("n", "md", function()
  require("telescope.builtin").git_files({ cwd = "~/.dotfiles" })
end, { desc = "Find Dot File" })

vim.keymap.set("n", "mC", function()
  require("telescope.builtin").find_files({ cwd = "~/.cache" })
end, { desc = "Find Cache File" })

vim.keymap.set("n", "mM", function()
  require("telescope.builtin").find_files({ cwd = "~/.memolist" })
end, { desc = "Find memolist file" })

vim.keymap.set("n", "mj", function()
  require("telescope.builtin").find_files({ cwd = "~/.cache/junkfile" })
end, { desc = "Find junk file" })

vim.keymap.set("n", "<space>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Open Old File" })

--------------------------------------------------------------------------------
-- Prefix "b" (vim-bookmarks) --
--------------------------------------------------------------------------------
vim.keymap.set("n", "<space>ba", function()
  require("telescope").extensions.vim_bookmarks.all()
end, { desc = "Bookmarks all" })
vim.keymap.set("n", "<space>bc", function()
  require("telescope").extensions.vim_bookmarks.current_file()
end, { desc = "Bookmarks current_file" })

--------------------------------------------------------------------------------
-- Prefix "h" (help) --
--------------------------------------------------------------------------------
vim.keymap.set("n", "<space>hc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<space>hh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
vim.keymap.set("n", "<space>hm", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
vim.keymap.set("n", "<space>hk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
vim.keymap.set("n", "<space>hs", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
vim.keymap.set("n", "<space>hf", "<cmd>Telescope filetypes<cr>", { desc = "File Types" })
vim.keymap.set("n", "<space>ho", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
vim.keymap.set("n", "<space>ha", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })

--------------------------------------------------------------------------------
-- Prefix "s" (search) --
--------------------------------------------------------------------------------
-- vim.keymap.set("n", "<space>sg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })
vim.keymap.set("n", "<space>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
vim.keymap.set("n", "<space>sh", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
vim.keymap.set("n", "<space>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
vim.keymap.set("n", "<space>sr", "<cmd>lua require('spectre').open()<cr>", { desc = "Replace (Spectre)" })

--------------------------------------------------------------------------------
-- Others
--------------------------------------------------------------------------------
vim.keymap.set("n", "<space>.", "<cmd>Telescope file_browser<cr>", { desc = "Browse Files" })
vim.keymap.set("n", "<space>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "Switch Buffer" })
vim.keymap.set("n", "<space>/", "<cmd>Telescope live_grep<cr>", { desc = "Search" })
vim.keymap.set({ "n", "x" }, "<space>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
