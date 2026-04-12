-- =============================================================================
-- File        : eyeliner.lua
-- Author      : yukimemi
-- Last Change : 2026/02/08 17:42:01.
-- =============================================================================

require 'eyeliner'.setup({
  -- show highlights only after keypress
  highlight_on_key = false,

  -- dim all other characters if set to true (recommended!)
  dim = true,

  -- set the maximum number of characters eyeliner.nvim will check from
  -- your current cursor position; this is useful if you are dealing with
  -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
  max_length = 9999,

  -- filetypes for which eyeliner should be disabled;
  -- e.g., to disable on help files:
  -- disabled_filetypes = {"help"}
  disabled_filetypes = {},

  -- buftypes for which eyeliner should be disabled
  -- e.g., disabled_buftypes = {"nofile"}
  disabled_buftypes = {},

  -- add eyeliner to f/F/t/T keymaps;
  -- see section on advanced configuration for more information
  default_keymaps = true,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup("MyEyelinerGroup", { clear = true }),
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
  end,
})

