return {
  "yukimemi/dps-ahdr",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g.ahdr_debug = false
    vim.g.ahdr_cfg_path = vim.fn.expand("~/.config/nvim/ahdr.toml")

    vim.api.nvim_create_user_command("DenopsAhdrDebug", function()
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = "MyAutoCmd",
        buffer = vim.fn.bufnr(),
        callback = function()
          vim.cmd([[DenopsAhdr waitcmd]])
        end
      })
    end, {})
  end,
}
