-- =============================================================================
-- File        : neo-tree.lua
-- Author      : yukimemi
-- Last Change : 2024/08/03 10:55:28.
-- =============================================================================

require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["/"] = "noop",
        ["l"] = "open",
      },
    },
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = false,
    },
  },
})

vim.keymap.set("n", "<space>e", "<cmd>Neotree focus filesystem left reveal_force_cwd<cr>")
