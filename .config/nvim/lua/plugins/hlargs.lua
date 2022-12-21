return {
  "m-demare/hlargs.nvim",
  event = "VeryLazy",
  enabled = false,
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
