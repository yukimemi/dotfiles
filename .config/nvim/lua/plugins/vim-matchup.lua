return {
  "andymass/vim-matchup",

  enabled = true,

  event = "VeryLazy",

  init = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}
