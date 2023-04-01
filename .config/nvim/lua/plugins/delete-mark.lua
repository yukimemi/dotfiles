return {
  "yuki-yano/delete-mark.nvim",

  event = "VeryLazy",

  opts = {
    mappings = {
      -- normal = "<C-x>",
      insert = "<C-x>",
      -- visual = "<C-x>",
    },
    events = { "TextChanged", "BufRead", "WinEnter", "InsertLeave" },
    highlight = {
      mark = { link = "Error" },
      sign = { link = "Error" },
      between = { link = "DiffDelete" },
    },
    sign = "X",
    tag = {
      open = "DELETE!: open",
      close = "DELETE!: close",
    },
    priority = 1000,
  },
}
