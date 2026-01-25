-- =============================================================================
-- File        : ssr.lua
-- Author      : yukimemi
-- Last Change : 2024/03/10 09:33:34.
-- =============================================================================

require("ssr").setup {
  border = "rounded",
  min_width = 50,
  min_height = 5,
  max_width = 120,
  max_height = 25,
  adjust_window = true,
  keymaps = {
    close = "q",
    next_match = "n",
    prev_match = "N",
    replace_confirm = "<cr>",
    replace_all = "<leader><cr>",
  },
}

vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)
