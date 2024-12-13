-- =============================================================================
-- File        : compl.lua
-- Author      : yukimemi
-- Last Change : 2024/12/09 02:13:36.
-- =============================================================================

vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess:append "c"

require("compl").setup({
  completion = {
    fuzzy = true,
  },
  snippet = {
    enable = true,
    paths = {
      vim.fn.expand("~/.cache/vscode"),
      vim.fn.expand("~/.cache/vscode-powershell"),
    },
  },
})

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
