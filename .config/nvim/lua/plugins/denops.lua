return {
  "vim-denops/denops.vim",

  lazy = false,

  init = function()
    if jit.os:find("Windows") then
      -- vim.g.denops_server_addr = "127.0.0.1:32123"
    end
  end,
}
