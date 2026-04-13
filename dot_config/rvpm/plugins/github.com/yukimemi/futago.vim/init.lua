vim.g.futago_debug = false
vim.g.futago_chat_path = "~/.cache/nvim/futago/chat"
vim.g.futago_log_file = "~/.cache/nvim/futago/log/futago.log"
vim.g.futago_history_db = "~/.cache/nvim/futago/db/history.db"
vim.g.futago_model = "gemini-3-flash-preview"
vim.g.futago_git_model = "gemini-3-flash-preview"
vim.g.futago_safety_settings = {
  { category = "HARM_CATEGORY_HATE_SPEECH", threshold = "BLOCK_NONE" },
  { category = "HARM_CATEGORY_SEXUALLY_EXPLICIT", threshold = "BLOCK_NONE" },
  { category = "HARM_CATEGORY_HARASSMENT", threshold = "BLOCK_NONE" },
  { category = "HARM_CATEGORY_DANGEROUS_CONTENT", threshold = "BLOCK_NONE" },
}
