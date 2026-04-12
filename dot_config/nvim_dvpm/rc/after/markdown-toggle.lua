-- =============================================================================
-- File        : markdown-toggle.lua
-- Author      : yukimemi
-- Last Change : 2024/07/13 20:13:42.
-- =============================================================================

require("markdown-toggle").setup({
  use_default_keymaps = false,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("MyMarkdownToggle", { clear = true }),
  desc = "markdown-toggle.nvim keymaps",
  pattern = { "markdown", "markdown.mdx" },
  callback = function(args)
    local opts = { silent = true, noremap = true, buffer = args.buf }
    local toggle = require("markdown-toggle")
    opts.expr = true -- required for dot-repeat in Normal mode
    -- vim.keymap.set("n", "<C-q>", toggle.quote_dot, opts)
    vim.keymap.set("n", "<C-p>", toggle.list_dot, opts)
    vim.keymap.set("n", "<C-n>", toggle.olist_dot, opts)
    vim.keymap.set("n", "<C-x>", toggle.checkbox_dot, opts)
    -- vim.keymap.set("n", "<C-h>", toggle.heading_dot, opts)

    opts.expr = false -- required for Visual mode
    -- vim.keymap.set("x", "<C-q>", toggle.quote, opts)
    vim.keymap.set("x", "<C-p>", toggle.list, opts)
    vim.keymap.set("x", "<C-n>", toggle.olist, opts)
    vim.keymap.set("x", "<C-x>", toggle.checkbox, opts)
    -- vim.keymap.set("x", "<C-h>", toggle.heading, opts)
  end,
})
