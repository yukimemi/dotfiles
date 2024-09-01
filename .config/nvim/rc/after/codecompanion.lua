-- =============================================================================
-- File        : codecompanion.lua
-- Author      : yukimemi
-- Last Change : 2024/09/01 17:08:53.
-- =============================================================================

require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "gemini",
    },
    inline = {
      adapter = "gemini",
    },
    agent = {
      adapter = "gemini",
    },
  },
})
