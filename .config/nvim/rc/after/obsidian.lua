-- =============================================================================
-- File        : obsidian.lua
-- Author      : yukimemi
-- Last Change : 2026/01/11 17:24:34
-- =============================================================================

local source = require("obsidian")
source.setup({
  workspaces = {
    {
      name = "personal",
      path = "~/obsidian",
    },
  },
  completion = {
    nvim_cmp = false,
    min_chars = 2,
  },
  mappings = {
    -- Smart action (links, tags, checkboxes)
    ["<cr>"] = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
    -- Overrides the 'gf' mapping to work on markdown/obsidian links within the vault.
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Create a new link from the visual selection
    ["<leader>on"] = {
      action = function()
        return require("obsidian").util.insert_link()
      end,
      opts = { buffer = true },
    },
  },
})

-- Snacks picker support for searching notes
local obsidian_path = vim.fn.expand("~/obsidian")

vim.keymap.set("n", "<leader>of", function()
  Snacks.picker.files({ cwd = obsidian_path })
end, { desc = "Find Obsidian notes (Snacks)" })

vim.keymap.set("n", "<leader>og", function()
  Snacks.picker.grep({ cwd = obsidian_path })
end, { desc = "Grep Obsidian notes (Snacks)" })

-- Override Obsidian commands to use Snacks picker
vim.api.nvim_create_user_command("ObsidianQuickSwitch", function()
  Snacks.picker.files({ cwd = obsidian_path })
end, { force = true })

vim.api.nvim_create_user_command("ObsidianSearch", function()
  Snacks.picker.grep({ cwd = obsidian_path })
end, { force = true })
