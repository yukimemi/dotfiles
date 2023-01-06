return {
  "skanehira/denops-twihi.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "twihi-timeline",
      callback = function()
        vim.keymap.set("n", "y", "<Plug>(twihi:tweet:yank)", { buffer = true })
        vim.keymap.set("n", "l", "<Plug>(twihi:tweet:like)", { buffer = true })
        vim.keymap.set("n", "o", "<Plug>(twihi:tweet:open)", { buffer = true })
        vim.keymap.set("n", "r", "<Plug>(twihi:reply)", { buffer = true })
        vim.keymap.set("n", "R", "<Plug>(twihi:retweet)", { buffer = true })
        vim.keymap.set("n", "T", "<Plug>(twihi:retweet:comment)", { buffer = true })
        vim.keymap.set("n", "j", "<Plug>(twihi:tweet:next)", { buffer = true })
        vim.keymap.set("n", "k", "<Plug>(twihi:tweet:prev)", { buffer = true })
        vim.keymap.set("n", "s", "<cmd>TwihiTweet<cr>", { buffer = true })
        vim.keymap.set("n", "S", ":<c-u>TwihiSearch<space>", { buffer = true })
      end,
    })

    vim.keymap.set("n", "<space>Th", "<cmd>TwihiHome<cr>")
    vim.keymap.set("n", "<space>Tm", "<cmd>TwihiMentions<cr>")
  end,
}
