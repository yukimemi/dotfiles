return {
  "yuki-yano/fuzzy-motion.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.keymap.set("n", "<cr>", "<cmd>FuzzyMotion<cr>")

    vim.g.fuzzy_motion_auto_jump = true
    vim.g.fuzzy_motion_disable_match_highlight = false
    vim.g.fuzzy_motion_word_regexp_list = {
      '[0-9a-zA-Z_-]+',
      '([0-9a-zA-Z_-]|[.])+',
      '([0-9a-zA-Z]|[()<>.-_#''"]|(\s=+\s)|(,\s)|(:\s)|(\s=>\s))+',
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"qf", "quickfix"},
      callback = function()
        vim.keymap.del("n", "<cr>", { buffer = true })
      end,
    })
  end,
}
