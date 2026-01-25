-- =============================================================================
-- File        : lemminx.lua
-- Author      : yukimemi
-- Last Change : 2025/05/05 20:45:15.
-- =============================================================================

---@type vim.lsp.Config
return {
  settings = {
    xml = {
      format = {
        enable = true,
        formatComments = true,
        joinCDATALines = false,
        joinCommentLines = false,
        joinContentLines = false,
        spaceBeforeEmptyCloseTag = true,
        splitAttributes = true,
      },
      completion = {
        autoCloseTags = true,
      },
    },
  },
}
