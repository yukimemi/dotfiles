-- =============================================================================
-- File        : rustaceanvim.lua
-- Author      : yukimemi
-- Last Change : 2024/01/06 15:39:33.
-- =============================================================================

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      require("nvim-navic").attach(client, bufnr)
      require("lsp").on_attach(client, bufnr)
    end,
    settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        diagnostics = {
          enable = true,
          -- disabled = { "unresolved-proc-macro" },
          enableExperimental = true,
        },
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}
