return {
  "danymat/neogen",

  cmd = "Neogen",

  config = function()
    require("neogen").setup({ snippet_engine = "luasnip" })
  end,
}
