return {
  "yukimemi/dps-asyngrep",

  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g.asyngrep_debug = false
    vim.g.asyngrep_cfg_path = vim.fn.expand("~/.config/nvim/asyngrep.toml")
    vim.keymap.set("n", "<space>ss", "<cmd>Agp<cr>")
    vim.keymap.set("n", "<space>sr", "<cmd>Agp --tool=ripgrep<cr>")
    vim.keymap.set("n", "<space>sp", "<cmd>Agp --tool=pt<cr>")
    vim.keymap.set("n", "<space>sj", "<cmd>Agp --tool=jvgrep<cr>")

    vim.keymap.set("n", "<space>sS", "<cmd>Agp --tool=default-all<cr>")
    vim.keymap.set("n", "<space>sR", "<cmd>Agp --tool=ripgrep-all<cr>")
    vim.keymap.set("n", "<space>sP", "<cmd>Agp --tool=pt-all<cr>")
    vim.keymap.set("n", "<space>sJ", "<cmd>Agp --tool=jvgrep-all<cr>")

  end,
}
