return {
  "yukimemi/dps-autobackup",

  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g.autobackup_debug = false
    vim.g.autobackup_enable = true
    vim.g.autobackup_write_echo = false
    vim.g.autobackup_dir = vim.o.backupdir .. "/autobackup"
    vim.g.autobackup_events = { "CursorHold", "CursorHoldI", "BufWritePre", "FocusLost", "FocusGained", "InsertLeave" }
    vim.g.autobackup_blacklist_filetypes = { "log", "csv" }
  end,
}
