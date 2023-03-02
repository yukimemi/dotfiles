-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "MyAutoCmd",
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Fix conceallevel for json & help files
vim.api.nvim_create_autocmd("FileType", {
  group = "MyAutoCmd",
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = "MyAutoCmd",
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
    "gin://*",
  },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { silent = true, buffer = true, nowait = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { silent = true, buffer = true, nowait = true })
    vim.opt.buflisted = false
  end,
})
