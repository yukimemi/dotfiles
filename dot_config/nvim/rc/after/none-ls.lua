-- =============================================================================
-- File        : none-ls.lua
-- Author      : yukimemi
-- Last Change : 2024/04/06 20:07:52.
-- =============================================================================

local nls = require("null-ls")
nls.setup({
  debounce = 150,
  save_after_format = true,

  sources = {
    -- diagnostics
    nls.builtins.diagnostics.dotenv_linter.with({
      condition = function()
        return vim.fn.executable("dotenv-linter") > 0
      end,
    }),
    nls.builtins.diagnostics.editorconfig_checker.with({
      condition = function()
        return vim.fn.executable("editorconfig-checker") > 0
      end,
    }),
    nls.builtins.diagnostics.markdownlint.with({
      condition = function()
        return vim.fn.executable("markdownlint") > 0
      end,
    }),
    nls.builtins.diagnostics.yamllint.with({
      condition = function()
        return vim.fn.executable("yamllint") > 0
      end,
    }),
    nls.builtins.diagnostics.zsh.with({
      condition = function()
        return vim.fn.executable("zsh") > 0
      end,
    }),

    -- formatting
    nls.builtins.formatting.black.with({
      condition = function()
        return vim.fn.executable("black") > 0
      end,
    }),
    nls.builtins.formatting.cbfmt.with({
      condition = function()
        return vim.fn.executable("cbfmt") > 0
      end,
    }),
    nls.builtins.formatting.codespell.with({
      condition = function()
        return vim.fn.executable("codespell") > 0
      end,
    }),
    nls.builtins.formatting.csharpier.with({
      condition = function()
        return vim.fn.executable("dotnet-csharpier") > 0
      end,
    }),
    nls.builtins.formatting.prettier.with({
      condition = function()
        return vim.fn.executable("prettier") > 0
      end,
      disabled_filetypes = {
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "typescript",
        "typescriptreact",
      },
    }),
    nls.builtins.formatting.gofmt.with({
      condition = function()
        return vim.fn.executable("gofmt") > 0
      end,
    }),
    nls.builtins.formatting.goimports.with({
      condition = function()
        return vim.fn.executable("goimports") > 0
      end,
    }),
    nls.builtins.formatting.isort.with({
      condition = function()
        return vim.fn.executable("isort") > 0
      end,
    }),
    nls.builtins.formatting.markdownlint.with({
      condition = function()
        return vim.fn.executable("markdownlint") > 0
      end,
    }),
    nls.builtins.formatting.mdformat.with({
      condition = function()
        return vim.fn.executable("mdformat") > 0
      end,
    }),
    nls.builtins.formatting.remark.with({
      condition = function()
        return vim.fn.executable("remark") > 0
      end,
    }),
    nls.builtins.formatting.shfmt.with({
      condition = function()
        return vim.fn.executable("shfmt") > 0
      end,
    }),
    nls.builtins.formatting.stylua.with({
      condition = function()
        -- return false
        return vim.fn.executable("stylua") > 0
      end,
    }),
    nls.builtins.formatting.textlint.with({
      condition = function()
        return vim.fn.executable("textlint") > 0
      end,
    }),
    nls.builtins.formatting.tidy.with({
      condition = function()
        -- return vim.fn.executable("tidy") > 0
        return false
      end,
    }),
    nls.builtins.formatting.yamlfmt.with({
      condition = function()
        return vim.fn.executable("yamlfmt") > 0
      end,
    }),

    -- code_actions
    nls.builtins.code_actions.gitsigns.with({
      condition = function()
        return false
      end,
    }),
  },
})
