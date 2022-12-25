local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",

  dependencies = {
    "folke/trouble.nvim",
    -- "ahmedkhalf/project.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
}

function M.config()
  local actions = require("telescope.actions")
  local trouble = require("trouble.providers.telescope")

  local telescope = require("telescope")
  local borderless = true

  telescope.setup({
    defaults = {
      layout_strategy = "horizontal",
      sorting_strategy = "ascending",
      mappings = {
        i = {
          ["<c-t>"] = trouble.open_with_trouble,
          ["<C-Down>"] = require("telescope.actions").cycle_history_next,
          ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
        },
      },
      prompt_prefix = " ",
      selection_caret = " ",
      winblend = borderless and 0 or 10,
    },
    extensions = {
      project = {
        base_dirs = {
          "~/src",
        },
      },
    },
  })

  telescope.load_extension("file_browser")
  telescope.load_extension("project")
  -- telescope.load_extension("projects")
end

function M.init()
  vim.keymap.set("n", "<space>ff", "<cmd>Telescope find_files<cr>", { desc = "Find File" })

  vim.keymap.set("n", "<space>fs", function()
    require("telescope.builtin").find_files({ cwd = "~/src" })
  end, { desc = "Find src file" })

  -- vim.keymap.set("n", "<space>fp", function()
  --   require("telescope").extensions.projects.projects()
  -- end, { desc = "Find Project" })
  vim.keymap.set("n", "<space>fp", function()
    require("telescope").extensions.project.project()
  end, { desc = "Find Project" })

  vim.keymap.set("n", "<space>fg", "<cmd>Telescope git_files<cr>", { desc = "Find git files" })

  vim.keymap.set("n", "<space>fD", function()
    require("telescope.builtin").git_files({ cwd = "~/.dotfiles" })
  end, { desc = "Find Dot File" })
end

return M
