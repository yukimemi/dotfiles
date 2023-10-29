return {
  "yukimemi/dps-autobackup",
  dev = false,

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.g.autobackup_debug = false
    vim.g.autobackup_enable = true
    vim.g.autobackup_write_echo = false
    vim.g.autobackup_use_ui_select = false
    -- vim.g.autobackup_dir = vim.o.backupdir .. "/autobackup"
    vim.g.autobackup_events = { "CursorHold", "CursorHoldI", "BufWritePre", "FocusLost", "FocusGained", "InsertLeave" }
    vim.g.autobackup_blacklist_filetypes = {
      "csv",
      "ctrlp",
      "ddu-ff",
      "ddu-ff-filter",
      "ddu-filer",
      "dpswalk",
      "gin-diff",
      "gin-status",
      "list",
      "log",
      "qf",
      "quickfix",
    }
  end,
}
