-- =============================================================================
-- File        : size-matters.lua
-- Author      : yukimemi
-- Last Change : 2023/12/04 01:33:27.
-- =============================================================================

require("size-matters").setup({
  default_mappings = false,
  -- font resize step size
  step_size = 1,
  notifications = {
    -- default value is true if notify is installed else false
    enable = true,
    -- ms how long a notifiation will be shown
    timeout = 150,
    -- depending on the client and if using multigrid, the time it takes for the client to re-render
    -- after a font size change can affect the position of the notification. Displaying it with a delay remedies this.
    delay = 200,
  },
  reset_font = vim.api.nvim_get_option("guifont"), -- Font loaded when using the reset cmd / shortcut
})

vim.keymap.set("n", "+", "<cmd>FontSizeUp<cr>")
vim.keymap.set("n", "-", "<cmd>FontSizeDown<cr>")
