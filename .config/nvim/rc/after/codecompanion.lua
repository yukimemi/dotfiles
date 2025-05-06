-- =============================================================================
-- File        : codecompanion.lua
-- Author      : yukimemi
-- Last Change : 2025/05/06 10:14:32.
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

-- vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<spaceLocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>",
  { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<space>cc", ":<c-u>CodeCompanion<space>", { noremap = true, silent = true })
