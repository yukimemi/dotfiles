-- =============================================================================
-- File        : toggleterm.lua
-- Author      : yukimemi
-- Last Change : 2025/01/01 20:13:44.
-- =============================================================================

local toggleterm = require("toggleterm")
local Terminal   = require('toggleterm.terminal').Terminal

toggleterm.setup()

vim.keymap.set("n", "<c-s>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
