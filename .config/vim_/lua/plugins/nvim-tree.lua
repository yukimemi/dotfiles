return {
  "nvim-tree/nvim-tree.lua",

  enabled = vim.g.plugin_use_nvimtree,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },

  keys = {
    { "ge", "<cmd>NvimTreeFindFile<cr>", mode = "n" },
  },

  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,

  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
    })
  end,
}
