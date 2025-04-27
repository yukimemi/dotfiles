-- =============================================================================
-- File        : codecompanion.lua
-- Author      : yukimemi
-- Last Change : 2025/04/27 20:16:36.
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
  language = "Japanese",
  adapters = {
    gemini = function()
      return require("codecompanion.adapters").extend("gemini", {
        schema = {
          model = {
            default = "gemini-2.5-flash-preview-04-17",
          },
        },
      })
    end,
  },
})
