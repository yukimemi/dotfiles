return {
  "vim-denops/denops.vim",

  init = function()
    vim.g.denops_server_addr = "127.0.0.1:32123"
  end,
  event = "VimEnter",
}
