return {
  "thinca/vim-partedit",

  cmd = "Partedit",

  init = function()
    vim.g["partedit#opener"] = "vsplit"
  end,
}
