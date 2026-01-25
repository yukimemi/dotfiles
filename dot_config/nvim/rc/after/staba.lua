-- =============================================================================
-- File        : staba.lua
-- Author      : yukimemi
-- Last Change : 2025/03/02 20:06:21.
-- =============================================================================

local ui = require('staba.icon.ui')

require('staba').setup({
  enable_fade = true,
  enable_underline = true, -- used as a horizontal separator for each buffer.
  enable_statuscolumn = true,
  enable_statusline = true,
  enable_tabline = true,
  mode_line = 'LineNr',                 -- choose from "LineNr"|"CursorLineNr"|"CursorLine"
  nav_keys = 'asdfghjklzxcvnmweryuiop', -- for assigning to navigation keys
  no_name = '[No Name]',                -- a buffer name for an empty buffer
  ignore_filetypes = {
    fade = {},
    statuscolumn = { 'qf', 'help', 'terminal' },
    statusline = { 'terminal' },
    tabline = {},
  },
  statuscolumn = { 'sign', 'number', 'fold_ex' },
  statusline = {
    active = {
      left = { 'staba_logo', 'search_count', 'noice_mode' },
      middle = {},
      right = { '%<', 'diagnostics', 'encoding', 'position' },
    },
    inactive = { left = {}, middle = { 'devicon', 'filename', '%*' }, right = {} },
  },
  tabline = {
    left = { 'bufinfo', 'parent', '/ ' },
    right = {},
    view = { 'buffers', 'tabs' },
    bufinfo = {
      '%#StabaTabsReverse#',
      'tab',
      '%#StabaBuffersReverse#',
      'buffer',
      '%#StabaModified#',
      'modified',
      '%#StabaSpecial#',
      'unopened',
      '%* ',
    },
    active = { 'devicon', 'namestate' },
    tabs = {
      self.frame.tabs_left,
      '%#StabaTabs#',
      'nav_key',
      self.frame.tabs_left,
      'namestate'
    },
    buffers = {
      self.frame.buffers_left,
      '%#StabaBuffers#',
      'nav_key',
      self.frame.buffers_left,
      'namestate'
    },
  },
  frame = {
    tabs_left = '%#StabaTabsReverse#' .. ui.frame.slant_d.left,
    tabs_right = '%#StabaTabsReverse#' .. ui.frame.bar.right,
    buffers_left = '%#StabaBuffersReverse#' .. ui.frame.slant_d.left,
    buffers_right = '%#StabaBuffersReverse#' .. ui.frame.bar.right,
    statusline_left = '%#StabaStatusReverse#' .. ui.frame.slant_u.left,
    statusline_right = '%#StabaStatusReverse#' .. ui.frame.slant_u.right,
  },
  sep = {
    normal_left = '%#TabLineFill#' .. ui.sep.arrow.left .. '%* ',
    normal_right = '%#TabLineFill#' .. ui.sep.arrow.right .. '%* ',
  },
  icons = {
    logo = { '', 'WarningMsg' },
    bar = '│',
    bufinfo = { tab = 'ᵀ', buffer = 'ᴮ', modified = 'ᴹ', unopened = 'ᵁ' },
    fold = { open = '󰍝', close = '󰍟', blank = ' ' }, -- "blank" is provided for adjusting ambiwidth.
    fileformat = {
      dos = { '', 'Changed' },
      mac = { '', 'Removed' },
      unix = { '', 'Added' },
    },
    severity = {
      Error = { '', 'DiagnosticSignError' },
      Warn = { '', 'DiagnosticSignWarn' },
      Hint = { '', 'DiagnosticSignHint' },
      Info = { '', 'DiagnosticSignInfo' },
    },
    status = {
      edit = '󰤌',
      lock = '󰍁',
      unlock = '  ',
      modify = '󰐖',
      nomodify = '  ',
    },
  },
})
