return {
  "brooth/far.vim",

  enabled = false,

  cmd = { "F", "Far", "Fardo", "Farf", "Farr" },

  keys = {
    { "<C-s>", "<cmd>Farf<cr>", mode = { "n", "x" } },
    { "<C-g>", "<cmd>Farr<cr>", mode = { "n", "x" } },
  },

  init = function()
    vim.g["far#enable_undo"] = 2
    vim.g["far#source"] = "rgnvim"
  end
}
