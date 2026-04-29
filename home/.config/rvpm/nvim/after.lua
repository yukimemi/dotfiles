-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 21:35:53.
-- =============================================================================

-- rvpm: open in terminal buffer, reuse if already running
local rvpm_buf = nil
local function rvpm_open()
  if rvpm_buf and vim.api.nvim_buf_is_valid(rvpm_buf) then
    local chan = vim.bo[rvpm_buf].channel
    local alive = chan and chan > 0 and vim.fn.jobwait({ chan }, 0)[1] == -1
    if alive then
      local wins = vim.fn.win_findbuf(rvpm_buf)
      if #wins > 0 then
        vim.api.nvim_set_current_win(wins[1])
      else
        vim.cmd("enew")
        vim.api.nvim_set_current_buf(rvpm_buf)
      end
      vim.cmd("startinsert")
      return
    end
    pcall(vim.api.nvim_buf_delete, rvpm_buf, { force = true })
    rvpm_buf = nil
  end
  vim.cmd("enew | terminal rvpm list")
  rvpm_buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = rvpm_buf,
    once = true,
    callback = function() rvpm_buf = nil end,
  })
  vim.cmd("startinsert")
end
vim.keymap.set("n", "<space>rp", rvpm_open, { silent = true, noremap = true })

-- Neovide
if vim.g.neovide then
  local font_name = "PlemolJP Console NF"
  vim.g.neovide_opacity = 0.95
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_profiler = false
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true

  if vim.fn.has("win32") == 1 then
    vim.o.guifont = font_name .. ":h10:#h-none"
    vim.o.guifontwide = font_name .. ":h10:#h-none"
  else
    vim.o.guifont = font_name .. ":h14:#h-none"
    vim.o.guifontwide = font_name .. ":h14:#h-none"
  end
end

-- Neovim-qt
if vim.fn.exists(":GuiFont") == 2 then
  vim.o.guifont = "PlemolJP Console NF:h10"
  vim.cmd("GuiFont! PlemolJP Console NF:h10")
end
if vim.fn.exists(":GuiTabline") == 2 then
  vim.cmd("GuiTabline 0")
end
if vim.fn.exists(":GuiPopupmenu") == 2 then
  vim.cmd("GuiPopupmenu 0")
end
if vim.fn.exists(":GuiScrollBar") == 2 then
  vim.cmd("GuiScrollBar 0")
end
if vim.fn.exists(":GuiWindowOpacity") == 2 then
  vim.cmd("GuiWindowOpacity 0.9")
end
--
-- Fallback colorscheme
vim.o.background = "dark"
vim.cmd("colorscheme habamax")
