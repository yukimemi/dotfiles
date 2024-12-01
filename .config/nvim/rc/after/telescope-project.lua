-- =============================================================================
-- File        : telescope-project.lua
-- Author      : yukimemi
-- Last Change : 2024/12/01 08:52:56.
-- =============================================================================

require("telescope").load_extension("project")

vim.keymap.set("n", "<space>fp", function()
  require("telescope").extensions.project.project()
end, { desc = "Find Project" })
