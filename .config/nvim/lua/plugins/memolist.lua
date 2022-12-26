return {
  "glidenote/memolist.vim",

  cmd = { "MemoList", "MemoNew", "MemoGrep" },

  init = function()
    if vim.fn.isdirectory("~/GoogleDrive") then
      vim.g.memolist_path = vim.fn.expand("~/GoogleDrive/.memolist")
    else
      vim.g.memolist_path = vim.fn.expand("~/.memolist")
    end

    vim.g.memolist_memo_suffix = "md"
    vim.g.memolist_prompt_tags = 1
  end,
}
