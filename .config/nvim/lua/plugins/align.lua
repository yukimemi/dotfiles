return {
  "Vonr/align.nvim",

  enabled = false,

  keys = {
    { "aa", function() require("align").align_to_char(1, true) end, mode = "x", noremap = true, silent = true },
    { "as", function() require("align").align_to_char(2, true, true) end, mode = "x", noremap = true, silent = true },
    { "aw", function() require("align").align_to_string(false, true, true) end, mode = "x", noremap = true, silent = true },
    { "ar", function() require("align").align_to_string(true, true, true) end, mode = "x", noremap = true, silent = true },
  },
}
