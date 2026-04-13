vim.g.autocursor_debug = false
vim.g.autocursor_notify = false
vim.g.autocursor_cursorline = {
  enable = true,
  events = {
    {
      name = {
        "BufEnter", "CmdwinLeave", "CursorHold", "CursorHoldI",
        "InsertLeave", "ModeChanged", "TextChanged", "VimResized", "WinEnter",
      },
      set = true,
      wait = 300,
    },
    {
      name = { "CursorMoved", "CursorMovedI", "InsertEnter" },
      set = false,
      wait = 0,
    },
  },
}
vim.g.autocursor_cursorcolumn = {
  enable = true,
  events = {
    {
      name = {
        "BufEnter", "CmdwinLeave", "CursorHold", "CursorHoldI",
        "InsertLeave", "ModeChanged", "TextChanged", "VimResized", "WinEnter",
      },
      set = true,
      wait = 300,
    },
    {
      name = { "CursorMoved", "CursorMovedI", "InsertEnter" },
      set = false,
      wait = 0,
    },
  },
}
vim.g.autocursor_ignore_filetypes = {
  "NvimTree", "TelescopePrompt", "aerial", "asyncwalker", "asyncwalker-filter",
  "coc-explorer", "ctrlp", "ddu", "ddu-ff", "ddu-ff-filter", "ddu-filer",
  "deck", "fall-help", "fall-input", "fall-list", "gundo", "list",
  "neo-tree", "qf", "quickfix", "undotree",
}
