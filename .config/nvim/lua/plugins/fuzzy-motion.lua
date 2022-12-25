return {
  "yuki-yano/fuzzy-motion.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    -- vim.keymap.set("n", "<cr>", "<cmd>FuzzyMotion<cr>")

    vim.g.fuzzy_motion_auto_jump = true
    vim.g.fuzzy_motion_disable_match_highlight = false

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"vim", "lua", "ps1", "log", "c", "typescript", "javascript"},
      callback = function()
        vim.keymap.set("n", "<cr>", "<cmd>FuzzyMotion<cr>", { buffer = true })
      end,
    })
  end,
}
