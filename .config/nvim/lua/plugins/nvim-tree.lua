return {
  "nvim-tree/nvim-tree.lua",

  enabled = true,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  cmd = {"NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse"},

  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.keymap.set("n", "ge", "<cmd>NvimTreeFindFile<cr>")
  end,

  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },
    })
  end,
}
