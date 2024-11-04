-- =============================================================================
-- File        : care.lua
-- Author      : yukimemi
-- Last Change : 2024/11/04 15:26:52.
-- =============================================================================

vim.keymap.set("i", "<c-k>", function()
  vim.snippet.jump(1)
end)
vim.keymap.set("i", "<c-j>", function()
  vim.snippet.jump(-1)
end)
vim.keymap.set("i", "<c-space>", function()
  require("care").api.complete()
end)
vim.keymap.set("i", "<c-e>", "<Plug>(CareClose)")
vim.keymap.set("i", "<tab>", "<Plug>(CareConfirm)")
vim.keymap.set("i", "<c-n>", "<Plug>(CareSelectNext)")
vim.keymap.set("i", "<c-p>", "<Plug>(CareSelectPrev)")

vim.keymap.set("i", "<c-f>", function()
  if require("care").api.doc_is_open() then
    require("care").api.scroll_docs(4)
  else
    vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
  end
end)

vim.keymap.set("i", "<c-d>", function()
  if require("care").api.doc_is_open() then
    require("care").api.scroll_docs(-4)
  else
    vim.api.nvim_feedkeys(vim.keycode("<c-d>"), "n", false)
  end
end)

require("care").setup({
  selection_behavior = "select",
  confirm_behavior = "insert",
  keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
  preselect = false,
  sorting_direction = "top-down",
  completion_events = { "TextChangedI" },
  enabled = function()
    local enabled = true
    if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
      enabled = false
    end
    return enabled
  end,
  max_view_entries = 200,
  debug = false,
})
