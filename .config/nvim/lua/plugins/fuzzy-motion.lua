return {
  "yuki-yano/fuzzy-motion.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
    "lambdalisue/kensaku.vim",
  },

  init = function()
    -- vim.keymap.set("n", "<cr>", "<cmd>FuzzyMotion<cr>")

    vim.g.fuzzy_motion_auto_jump = false
    vim.g.fuzzy_motion_disable_match_highlight = false
    vim.g.fuzzy_motion_matchers = { "fzf", "kensaku" }

    vim.keymap.set("n", "ss", "<cmd>FuzzyMotion<cr>")
  end,
}
