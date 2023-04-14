return {
  "yuki-yano/vim-operator-replace",

  keys = {
    { "_", "<Plug>(operator-replace)", mode = {"n", "x"} },
  },

  dependencies = {
    "kana/vim-operator-user",
  },
}
