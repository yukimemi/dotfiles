return {
  "monaqa/modesearch.vim",

  keys = {
    { "g/", "<Plug>(modesearch-slash)", mode = { "n", "x" }, desc = "modesearch slash" },
    { "g?", "<Plug>(modesearch-question)", mode = { "n", "x" }, desc = "modesearch slash" },
    { "<C-x>", "<Plug>(modesearch-toggle-mode)", mode = "c", desc = "modesearch toggle" },
  },
}
