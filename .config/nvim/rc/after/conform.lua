-- =============================================================================
-- File        : conform.lua
-- Author      : yukimemi
-- Last Change : 2024/05/12 18:30:51.
-- =============================================================================

local conform = require("conform")

conform.setup({
  format_after_save = {
    lsp_fallback = true,
  },
  formatters_by_ft = {
    typescriptreact = {
      "deno_fmt"
    },
    json = {
      "deno_fmt"
    }
  }
})

vim.keymap.set("n", "<leader>F", function()
  conform.format({
    timeout_ms = 1000,
    lsp_fallback = true,
  })
end, { desc = "Format code" })
