return {
  "m-demare/hlargs.nvim",

  event = "VeryLazy",
  enabled = true,

  config = function()
    require("hlargs").setup({
      excluded_argnames = {
        usages = {
          lua = { "self", "use" },
        },
      },
    })
  end,
}
