return {
  "pepo-le/win-ime-con.nvim",

  -- enabled = jit.os:find("Windows"),
  enabled = false,

  event = "InsertEnter",

  init = function()
    vim.g.win_ime_con_mode = 0
    vim.g.python3_host_prog = vim.env.APPDATA .. "/Local/Programs/Python/Python312/python.exe"
  end,
}
