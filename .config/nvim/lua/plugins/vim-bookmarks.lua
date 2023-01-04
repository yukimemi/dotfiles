return {
  "MattesGroeger/vim-bookmarks",

  event = "VeryLazy",

  init = function()
    vim.g.bookmark_disable_ctrlp = 1
  end,
}
