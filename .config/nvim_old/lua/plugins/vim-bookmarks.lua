return {
  "MattesGroeger/vim-bookmarks",

  enabled = vim.g.plugin_use_bookmark,

  event = "VeryLazy",

  init = function()
    vim.g.bookmark_disable_ctrlp = 1
  end,
}
