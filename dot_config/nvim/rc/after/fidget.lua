-- =============================================================================
-- File        : fidget.lua
-- Author      : yukimemi
-- Last Change : 2024/11/10 13:14:13.
-- =============================================================================

require("fidget").setup({
  notification = {
    override_vim_notify = true,
  },
})

vim.keymap.set("n", "<space>fl", "<cmd>L Fidget history<cr>", { desc = "Fidget history" })
