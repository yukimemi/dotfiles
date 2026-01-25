return {
  "lambdalisue/vim-kensaku-search",

  dependencies = {
    "lambdalisue/vim-kensaku",
  },

  keys = {
    { "<cr>", "<Plug>(kensaku-search-replace)<cr>", mode = "c" },
  },
}
