require("smoothcursor").setup({
  autostart = true,
  cursor = "",
  texthl = "SmoothCursor",
  linehl = nil,
  type = "default",
  fancy = {
    enable = true,
    head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
    body = {
      { cursor = "★", texthl = "SmoothCursorRed" },
      { cursor = "☆", texthl = "SmoothCursorOrange" },
      { cursor = "󱐋", texthl = "SmoothCursorYellow" },
      { cursor = "󱐌", texthl = "SmoothCursorGreen" },
      { cursor = "•", texthl = "SmoothCursorAqua" },
      { cursor = ".", texthl = "SmoothCursorBlue" },
      { cursor = ".", texthl = "SmoothCursorPurple" },
    },
    tail = { cursor = nil, texthl = "SmoothCursor" },
  },
  flyin_effect = "bottom",
  speed = 25,
  intervals = 35,
  priority = 10,
  timeout = 3000,
  threshold = 3,
  disable_float_win = false,
  enabled_filetypes = nil,
  disabled_filetypes = {
    "NvimTree", "TelescopePrompt", "aerial", "asyncwalker", "asyncwalker-filter",
    "coc-explorer", "ctrlp", "ddu", "ddu-ff", "ddu-ff-filter", "ddu-filer",
    "fall-help", "fall-input", "fall-list", "gundo", "list",
    "neo-tree", "qf", "quickfix", "undotree",
  },
})

local group = vim.api.nvim_create_augroup("MySmoothCursor", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
  group = group,
  pattern = "*",
  callback = function()
    local mode = vim.fn.mode()
    if mode == "n" then
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#8aa872" })
      vim.fn.sign_define("smoothcursor", { text = "▷" })
    elseif mode == "v" then
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
      vim.fn.sign_define("smoothcursor", { text = "" })
    elseif mode == "V" then
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
      vim.fn.sign_define("smoothcursor", { text = "" })
    elseif mode == "\22" then
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
      vim.fn.sign_define("smoothcursor", { text = "" })
    elseif mode == "i" then
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#668aab" })
      vim.fn.sign_define("smoothcursor", { text = "" })
    end
  end,
})
