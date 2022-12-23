local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },

  dependencies = {
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-project.nvim" },
    { "nvim-telescope/telescope-symbols.nvim" },
  },
}

function M.project_files(opts)
  opts = opts or {}
  opts.show_untracked = true
  if vim.loop.fs_stat(".git") then
    require("telescope.builtin").git_files(opts)
  else
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
  end
end

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
  })

  -- telescope.load_extension("frecency")
  telescope.load_extension("file_browser")
  -- telescope.load_extension("project")
end

function M.init()
  vim.keymap.set("n", "<leader>fp", function()
    require("plugins.telescope").project_files()
  end, { desc = "Find File" })

  vim.keymap.set("n", "<leader>fd", function()
    require("telescope.builtin").git_files({ cwd = "~/.dotfiles" })
  end, { desc = "Find Dot File" })

  vim.keymap.set("n", "<leader>fz", function()
    require("telescope").extensions.z.list({ cmd = { vim.o.shell, "-c", "zoxide query -ls" } })
  end, { desc = "Find Zoxide" })

  vim.keymap.set("n", "<leader>pp", function()
    require("telescope").extensions.project.project({})
  end, { desc = "Find Project" })
end

return M
