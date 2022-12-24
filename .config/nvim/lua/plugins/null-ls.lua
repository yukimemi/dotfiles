local M = {
  "jose-elias-alvarez/null-ls.nvim",

  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
  }
}

function M.setup(options)
  local nls = require("null-ls")
  nls.setup({
    debounce = 150,
    save_after_format = false,

    sources = {
      -- completion
      nls.builtins.completion.spell,

      -- diagnostics
      nls.builtins.diagnostics.cspell,
      nls.builtins.diagnostics.dotenv_linter,
      nls.builtins.diagnostics.editorconfig_checker,
      nls.builtins.diagnostics.flake8,
      nls.builtins.diagnostics.luacheck,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.yamllint,
      nls.builtins.diagnostics.zsh,

      -- formatting
      nls.builtins.formatting.black,
      nls.builtins.formatting.cbfmt,
      nls.builtins.formatting.codespell,
      nls.builtins.formatting.csharpier,
      nls.builtins.formatting.deno_fmt,
      nls.builtins.formatting.dprint,
      nls.builtins.formatting.fixjson,
      nls.builtins.formatting.gofmt,
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.isort,
      nls.builtins.formatting.jq,
      nls.builtins.formatting.lua_format,
      nls.builtins.formatting.markdownlint,
      nls.builtins.formatting.mdformat,
      nls.builtins.formatting.remark,
      nls.builtins.formatting.rustfmt,
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.taplo,
      nls.builtins.formatting.textlint,
      nls.builtins.formatting.tidy,
      nls.builtins.formatting.xmlformat,
      nls.builtins.formatting.xmllint,
      nls.builtins.formatting.yamlfmt,

      -- code_actions
      nls.builtins.code_actions.cspell,
      nls.builtins.code_actions.gitsigns,
    },
    on_attach = options.on_attach,
  })
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
