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

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "vim",
        "lua",
        "ps1",
        "log",
        "c",
        "typescript",
        "javascript",
        "xml",
        "markdown",
        "plantuml"
      },

      callback = function()
        vim.keymap.set("n", "<cr>", "<cmd>FuzzyMotion<cr>", { buffer = true })
      end,
    })
  end,
}
