return {
  "Exafunction/codeium.vim",

  event = "InsertEnter",

  cmd = "Codeium",

  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set('i', '<C-g>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true })
  end,
}
