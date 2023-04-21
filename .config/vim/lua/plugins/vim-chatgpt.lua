return {
  "mattn/vim-chatgpt",

  enabled = false,

  build = "go install github.com/mattn/chatgpt@latest",

  cmd = { "ChatGPT", "CodeReviewPlease" },
}
