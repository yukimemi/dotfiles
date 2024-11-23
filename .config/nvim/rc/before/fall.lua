-- =============================================================================
-- File        : fall.lua
-- Author      : yukimemi
-- Last Change : 2024/11/23 21:32:39.
-- =============================================================================

vim.keymap.set("n", "<space>lf", "<cmd>Fall file<cr>", { desc = "Fall file" })
vim.keymap.set("n", "<space>la", "<cmd>Fall file:all<cr>", { desc = "Fall file:all" })

vim.keymap.set("n", "md", "<cmd>Fall file ~/.dotfiles<cr>", { desc = "Fall dotfiles" })
vim.keymap.set("n", "ms", "<cmd>Fall file ~/src<cr>", { desc = "Fall src" })
vim.keymap.set("n", "mC", "<cmd>Fall file ~/.cache<cr>", { desc = "Fall cache" })
vim.keymap.set("n", "mM", "<cmd>Fall file ~/.memolist<cr>", { desc = "Fall memolist" })

vim.keymap.set("n", "mb", function()
  local bufdir = vim.fn.expand("%:p:h")
  vim.cmd("Fall file " .. bufdir)
end, { desc = "Fall buffer dir" })

vim.keymap.set("n", "m,", "<cmd>Fall buffer<cr>", { desc = "Fall buffer" })

vim.keymap.set("n", "<space>lr", "<cmd>Fall rg<cr>", { desc = "Fall rg" })
vim.keymap.set("n", "<space>lg", "<cmd>Fall git-grep<cr>", { desc = "Fall git-grep" })
vim.keymap.set("n", "<space>ll", "<cmd>Fall line<cr>", { desc = "Fall line" })
vim.keymap.set("n", "<space>lh", "<cmd>Fall help<cr>", { desc = "Fall help" })

-- chronicle.vim
vim.keymap.set("n", "mr", "<cmd>Fall chronicle:read<cr>", { desc = "Fall chronicle:read" })
vim.keymap.set("n", "mw", "<cmd>Fall chronicle:write<cr>", { desc = "Fall chronicle:write" })

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("MyFallPickerEnter", { clear = true }),
  pattern = "FallPickerEnter:*",
  callback = function()
    vim.keymap.set("c", "<c-n>", '<Plug>(fall-list-next)', { nowait = true })
    vim.keymap.set("c", "<c-p>", '<Plug>(fall-list-prev)', { nowait = true })
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("MyFallPickerLeave", { clear = true }),
  pattern = "FallPickerLeave:*",
  callback = function()
    vim.keymap.set("c", "<c-n>", '<down>', { nowait = true })
    vim.keymap.set("c", "<c-p>", '<up>', { nowait = true })
  end,
})
