-- =============================================================================
-- File        : powershell_es.lua
-- Author      : yukimemi
-- Last Change : 2025/05/05 20:43:00.
-- =============================================================================

---@type vim.lsp.Config
return {
  settings = {
    powershell = {
      single_file_support = true,
      codeLens = true,
      codeFormatting = {
        preset = "OTBS",
        ignoreOneLineBlock = false,
        useCorrectCasing = true,
        autoCorrectAliases = true,
      },
    },
  },
}
