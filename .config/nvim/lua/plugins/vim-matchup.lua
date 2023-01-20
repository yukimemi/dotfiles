return {
  "andymass/vim-matchup",

  event = "VeryLazy",

  init = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}
