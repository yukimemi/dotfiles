-- =============================================================================
-- File        : powershell_es.lua
-- Author      : yukimemi
-- Last Change : 2026/03/05 17:26:29.
-- =============================================================================

---@type vim.lsp.Config
return {
  settings = {
    powershell = {
      single_file_support = true,
      codeLens = true,
      codeFormatting = {
        preset = "OTBS",
        ignoreOneLineBlock = true,
        useCorrectCasing = true,
        autoCorrectAliases = true,
      },
    },
  },
}
