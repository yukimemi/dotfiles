return {
  "glidenote/memolist.vim",

  keys = {
    { "<space>mn", "<cmd>MemoNew<cr>", mode = "n" },
  },

  cmd = { "MemoList", "MemoNew", "MemoGrep" },

  init = function()
    vim.g.memolist_path = vim.fn.expand("~/.memolist")

    vim.g.memolist_memo_suffix = "md"
    vim.g.memolist_prompt_tags = 1
  end,
}
