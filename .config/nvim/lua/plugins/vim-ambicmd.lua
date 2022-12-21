return {
  "thinca/vim-ambicmd",

  lazy = false,

  init = function()
    vim.keymap.set("c", "<space>", vim.fn['ambicmd#expand']("<space>"), { expr = true })
    vim.keymap.set("c", "<cr>", vim.fn['ambicmd#expand']("<cr>"), { expr = true })
    vim.keymap.set("c", "<c-f>", vim.fn['ambicmd#expand']("<right>"), { expr = true })
  end,
}
