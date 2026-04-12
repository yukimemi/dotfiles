-- =============================================================================
-- File        : codecompanion.lua
-- Author      : yukimemi
-- Last Change : 2025/09/28 18:02:27.
-- =============================================================================

require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "gemini",
    },
    inline = {
      adapter = "gemini",
    },
    cmd = {
      adapter = "gemini",
    },
  },
  language = "Japanese",
})

-- vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<localleader>a", "<cmd>CodeCompanionChat Toggle<cr>",
  { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<space>cc", ":<c-u>CodeCompanion<space>", { noremap = true, silent = true })
