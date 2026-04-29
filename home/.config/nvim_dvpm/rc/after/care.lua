-- =============================================================================
-- File        : care.lua
-- Author      : yukimemi
-- Last Change : 2024/12/09 02:16:39.
-- =============================================================================

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if vim.snippet.active { direction = 1 } then
    return "<cmd>lua vim.snippet.jump(1)<cr>"
  end
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if vim.snippet.active { direction = -1 } then
    return "<cmd>lua vim.snippet.jump(-1)<cr>"
  end
end, { expr = true })

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
