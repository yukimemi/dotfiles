-- =============================================================================
-- File        : conform.lua
-- Author      : yukimemi
-- Last Change : 2024/10/18 19:18:52.
-- =============================================================================

local conform = require("conform")

conform.setup({
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = {
    timeout_ms = 5000,
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
