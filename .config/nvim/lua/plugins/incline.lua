local M = {
  "b0o/incline.nvim",
  event = "BufReadPre",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter-context",
  },
}

function M.config()
  require('incline').setup({
    window = {
      width = 'fit',
      placement = { horizontal = 'right', vertical = 'top' },
      margin = {
        horizontal = { left = 1, right = 0 },
        vertical = { bottom = 0, top = 1 },
      },
      padding = { left = 1, right = 1 },
      padding_char = ' ',
      winhighlight = {
        Normal = 'TreesitterContext',
      },
    },
    hide = {
      -- focused_win = true,
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
      local icon, color = require('nvim-web-devicons').get_icon_color(filename)
      return {
        { icon, guifg = color },
        { ' ' },
        { filename },
      }
    end
  })
end

return M
