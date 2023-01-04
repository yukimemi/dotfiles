local M = {
  "jose-elias-alvarez/null-ls.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.setup(options)
  local nls = require("null-ls")
  nls.setup({
    debounce = 150,
    save_after_format = false,

    sources = {
      -- completion
      -- nls.builtins.completion.spell,

      -- diagnostics
      nls.builtins.diagnostics.cspell.with({
        condition = function()
          return vim.fn.executable("cspell") > 0
        end,
      }),
      nls.builtins.diagnostics.dotenv_linter,
      nls.builtins.diagnostics.editorconfig_checker.with({
        condition = function()
          return vim.fn.executable("ec") > 0
        end,
      }),
      nls.builtins.diagnostics.flake8,
      nls.builtins.diagnostics.markdownlint.with({
        condition = function()
          return vim.fn.executable("markdownlint") > 0
        end,
      }),
      nls.builtins.diagnostics.shellcheck.with({
        condition = function()
          return vim.fn.executable("shellcheck") > 0
        end,
      }),
      nls.builtins.diagnostics.yamllint.with({
        condition = function()
          return vim.fn.executable("yamllint") > 0
        end,
      }),
      nls.builtins.diagnostics.zsh,

      -- formatting
      nls.builtins.formatting.black.with({
        condition = function()
          return vim.fn.executable("black") > 0
        end,
      }),
      nls.builtins.formatting.cbfmt,
      nls.builtins.formatting.codespell.with({
        condition = function()
          return vim.fn.executable("codespell") > 0
        end,
      }),
      nls.builtins.formatting.csharpier,
      nls.builtins.formatting.deno_fmt,
      nls.builtins.formatting.dprint.with({
        condition = function()
          return vim.fn.executable("dprint") > 0
        end,
      }),
      nls.builtins.formatting.fixjson.with({
        condition = function()
          return vim.fn.executable("fixjson") > 0
        end,
      }),
      nls.builtins.formatting.gofmt,
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.isort,
      nls.builtins.formatting.jq.with({
        condition = function()
          return vim.fn.executable("jq") > 0
        end,
      }),
      nls.builtins.formatting.markdownlint.with({
        condition = function()
          return vim.fn.executable("markdownlint") > 0
        end,
      }),
      nls.builtins.formatting.mdformat,
      nls.builtins.formatting.remark,
      nls.builtins.formatting.rustfmt,
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.stylua.with({
        condition = function()
          return false
          -- return vim.fn.executable("stylua") > 0
        end,
      }),
      nls.builtins.formatting.taplo,
      nls.builtins.formatting.textlint.with({
        condition = function()
          return vim.fn.executable("textlint") > 0
        end,
      }),
      nls.builtins.formatting.tidy.with({
        condition = function()
          return vim.fn.executable("tidy") > 0
        end,
      }),
      nls.builtins.formatting.xmlformat,
      nls.builtins.formatting.xmllint.with({
        condition = function()
          return vim.fn.executable("xmllint") > 0
        end,
      }),
      nls.builtins.formatting.yamlfmt,

      -- code_actions
      nls.builtins.code_actions.cspell,
      nls.builtins.code_actions.gitsigns,
    },
    on_attach = options.on_attach,
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
  })
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
