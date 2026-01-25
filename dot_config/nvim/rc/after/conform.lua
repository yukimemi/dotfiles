-- =============================================================================
-- File        : conform.lua
-- Author      : yukimemi
-- Last Change : 2025/05/11 09:24:08.
-- =============================================================================

local conform = require("conform")

conform.setup({
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 5000,
  },
  format_after_save = {
    lsp_format = "fallback",
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
    timeout_ms = 30000,
    lsp_fallback = true,
  })
end, { desc = "Format code" })
