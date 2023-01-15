vim.api.nvim_create_autocmd("UIEnter", {
  group = "MyAutoCmd",
  pattern = "*",
  once = true,
  callback = function()
    if vim.fn.exists(":GuiFont") > 0 then
      vim.cmd([[GuiFont! HackGen Console NF:h10]])
    end
    if vim.fn.exists(":GuiTabline") > 0 then
      vim.cmd([[GuiTabline 0]])
    end
    if vim.fn.exists(":GuiPopupmenu") > 0 then
      vim.cmd([[GuiPopupmenu 0]])
    end
    if vim.fn.exists(":GuiScrollBar") > 0 then
      vim.cmd([[GuiScrollBar 0]])
    end
    if vim.fn.exists(":GuiWindowOpacity") > 0 then
      vim.cmd([[GuiWindowOpacity 0.9]])
    end
  end,
})
