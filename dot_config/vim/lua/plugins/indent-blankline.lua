return {
  "lukas-reineke/indent-blankline.nvim",

  event = "BufReadPre",

  config = function()
    require("indent_blankline").setup({
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
    })
  end,
}
