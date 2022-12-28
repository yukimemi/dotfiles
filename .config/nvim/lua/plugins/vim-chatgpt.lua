return {
  "mattn/vim-chatgpt",

  build = "go install github.com/mattn/chatgpt@latest",

  cmd = { "ChatGPT", "CodeReviewPlease" },
}
