-- =============================================================================
-- File        : rust-tools.lua
-- Author      : yukimemi
-- Last Change : 2023/12/04 01:33:23.
-- =============================================================================

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr, noremap = true, desc = "Hover actions" })
      -- Code action groups
      vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group,
        { buffer = bufnr, noremap = true, desc = "Code action group" })
      -- Default nvim-lspconfig keymaps
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, noremap = true, desc = "Diagnostic prev" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, noremap = true, desc = "Diagnostic next" })
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = bufnr, noremap = true, desc = "Rename" })
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = bufnr, noremap = true, desc = "Code action" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, noremap = true, desc = "Declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, noremap = true, desc = "Definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, noremap = true, desc = "References" })
      vim.keymap.set("n", "<space>F", function()
        vim.lsp.buf.format({ async = true })
      end, { buffer = bufnr, noremap = true, desc = "Format code" })
    end,
  },
})
