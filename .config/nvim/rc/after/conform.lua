local conform = require("conform")

conform.setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

vim.keymap.set("n", "<leader>F", function()
  conform.format({
    timeout_ms = 1000,
    lsp_fallback = true,
  })
end, { desc = "Format code" })
