-- =============================================================================
-- File        : toggleterm.lua
-- Author      : yukimemi
-- Last Change : 2025/01/01 21:21:54.
-- =============================================================================

local toggleterm = require("toggleterm")
local Terminal   = require('toggleterm.terminal').Terminal

toggleterm.setup()

vim.keymap.set("n", "<c-s>", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })

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

-- vim.keymap.set("n", "<space>gg", "<cmd>lua _lazygit_toggle()<cr>", { noremap = true, silent = true })
