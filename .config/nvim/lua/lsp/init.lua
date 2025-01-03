local M = {}

function M.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  -- you can also put keymaps in here
  require("nvim-navic").attach(client, bufnr)
  -- require("lsp-format").on_attach(client, bufnr)

  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set(
    "n",
    "<space>f",
    vim.diagnostic.open_float,
    vim.tbl_extend("force", opts, { desc = "Open diagnostic on float" })
  )
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Diagnostic prev" }))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Diagnostic next" }))
  vim.keymap.set(
    "n",
    "<space>q",
    vim.diagnostic.setloclist,
    vim.tbl_extend("force", opts, { desc = "Diagnostic to loclist" })
  )
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Declaration" }))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Definition" }))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Implementation" }))
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
  vim.keymap.set(
    "n",
    "<localleader>wa",
    vim.lsp.buf.add_workspace_folder,
    vim.tbl_extend("force", opts, { desc = "Add workspace folder" })
  )
  vim.keymap.set(
    "n",
    "<localleader>wr",
    vim.lsp.buf.remove_workspace_folder,
    vim.tbl_extend("force", opts, { desc = "Remove workspace folder" })
  )
  vim.keymap.set("n", "<localleader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))
  vim.keymap.set(
    "n",
    "<space>D",
    vim.lsp.buf.type_definition,
    vim.tbl_extend("force", opts, { desc = "Type definition" })
  )
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
  -- vim.keymap.set("n", "<space>F", function()
  --   vim.lsp.buf.format({ async = true })
  -- end, vim.tbl_extend("force", opts, { desc = "Format code" }))
end

return M
