-- =============================================================================
-- File        : codecompanion.lua
-- Author      : yukimemi
-- Last Change : 2025/02/01 21:23:54.
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
            default = "gemini-2.0-flash-thinking-exp",
          },
        },
      })
    end,
  },
})

