// =============================================================================
// File        : telescope.ts
// Author      : yukimemi
// Last Change : 2023/11/01 21:34:49.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.5.0/mod.ts";

import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/mod.ts";

export const telescope: Plug[] = [
  {
    url: "https://github.com/nvim-telescope/telescope.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    dependencies: [
      { url: "https://github.com/folke/which-key.nvim" },
      { url: "https://github.com/folke/trouble.nvim" },
      { url: "https://github.com/nvim-telescope/telescope-file-browser.nvim" },
      { url: "https://github.com/nvim-telescope/telescope-project.nvim" },
      { url: "https://github.com/nvim-telescope/telescope-symbols.nvim" },
      {
        url: "https://github.com/fdschmidt93/telescope-egrepify.nvim",
        dependencies: [
          { url: "https://github.com/nvim-lua/plenary.nvim" },
          { url: "https://github.com/nvim-telescope/telescope.nvim" },
        ],
        after: async ({ denops }) => {
          await execute(
            denops,
            `
                lua << EOB
                  require"telescope".load_extension("egrepify")
                EOB
              `,
          );
        },
      },
      {
        url: "https://github.com/tom-anders/telescope-vim-bookmarks.nvim",
        dependencies: [
          { url: "https://github.com/MattesGroeger/vim-bookmarks" },
        ],
      },
      {
        url: "https://github.com/danielfalk/smart-open.nvim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) =>
          denops.meta.host === "nvim" && Deno.build.os !== "windows" && false,
        dependencies: [
          { url: "https://github.com/kkharji/sqlite.lua" },
          { url: "https://github.com/nvim-telescope/telescope.nvim" },
        ],
        after: async ({ denops }) => {
          await execute(
            denops,
            `
                lua << EOB
                  require"telescope".load_extension("smart_open")
                  vim.keymap.set("n", "<space>fs", "<cmd>Telescope smart_open<cr>", { desc = "Smart Open" })
                EOB
              `,
          );
        },
      },
    ],
    before: async ({ denops }) => {
      await execute(
        denops,
        `
          lua << EOB
            --------------------------------------------------------------------------------
            -- Prefix "f" (files) --
            --------------------------------------------------------------------------------
            vim.keymap.set("n", "<space>ff", "<cmd>Telescope<cr>", { desc = "Telescope" })

            vim.keymap.set("n", "<space>fS", function()
              require("telescope.builtin").find_files({ cwd = "~/src" })
            end, { desc = "Find src file" })

            -- vim.keymap.set("n", "<space>fp", function()
            --   require("telescope").extensions.projects.projects()
            -- end, { desc = "Find Project" })
            vim.keymap.set("n", "<space>fp", function()
              require("telescope").extensions.project.project()
            end, { desc = "Find Project" })

            vim.keymap.set("n", "<space>fg", "<cmd>Telescope git_files<cr>", { desc = "Find git files" })

            vim.keymap.set("n", "<space>fd", function()
              local bufname = vim.fn.bufname()
              local bufdir = vim.fn.fnamemodify(bufname, ":p:h")
              require("telescope.builtin").find_files({ cwd = bufdir })
            end, { desc = "Find file on buffer dir" })

            vim.keymap.set("n", "<space>fD", function()
              require("telescope.builtin").git_files({ cwd = "~/.dotfiles" })
            end, { desc = "Find Dot File" })

            vim.keymap.set("n", "<space>fc", function()
              require("telescope.builtin").git_files({ cwd = "~/.cache" })
            end, { desc = "Find Cache File" })

            vim.keymap.set("n", "<space>fm", function()
              require("telescope.builtin").find_files({ cwd = "~/.memolist" })
            end, { desc = "Find memolist file" })

            vim.keymap.set("n", "<space>fj", function()
              require("telescope.builtin").find_files({ cwd = "~/.cache/junkfile" })
            end, { desc = "Find junk file" })

            vim.keymap.set("n", "<space>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Open Old File" })

            --------------------------------------------------------------------------------
            -- Prefix "b" (vim-bookmarks) --
            --------------------------------------------------------------------------------
            vim.keymap.set("n", "<space>ba", function()
              require("telescope").extensions.vim_bookmarks.all()
            end, { desc = "Bookmarks all" })
            vim.keymap.set("n", "<space>bc", function()
              require("telescope").extensions.vim_bookmarks.current_file()
            end, { desc = "Bookmarks current_file" })

            --------------------------------------------------------------------------------
            -- Prefix "h" (help) --
            --------------------------------------------------------------------------------
            vim.keymap.set("n", "<space>hc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
            vim.keymap.set("n", "<space>hh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
            vim.keymap.set("n", "<space>hm", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
            vim.keymap.set("n", "<space>hk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
            vim.keymap.set("n", "<space>hs", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
            vim.keymap.set("n", "<space>hf", "<cmd>Telescope filetypes<cr>", { desc = "File Types" })
            vim.keymap.set("n", "<space>ho", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
            vim.keymap.set("n", "<space>ha", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })

            --------------------------------------------------------------------------------
            -- Prefix "s" (search) --
            --------------------------------------------------------------------------------
            -- vim.keymap.set("n", "<space>sg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })
            vim.keymap.set("n", "<space>sg", "<cmd>Telescope egrepify<cr>", { desc = "Grep" })
            vim.keymap.set("n", "<space>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
            vim.keymap.set("n", "<space>sh", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
            vim.keymap.set("n", "<space>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
            vim.keymap.set("n", "<space>sr", "<cmd>lua require('spectre').open()<cr>", { desc = "Replace (Spectre)" })

            --------------------------------------------------------------------------------
            -- Prefix "p" (project) --
            --------------------------------------------------------------------------------
            vim.keymap.set("n", "<space>pp", "<cmd>Telescope file_browser cwd=~/src<cr>", { desc = "Browse ~/src" })

            --------------------------------------------------------------------------------
            -- Others
            --------------------------------------------------------------------------------
            vim.keymap.set("n", "<space>.", "<cmd>Telescope file_browser<cr>", { desc = "Browse Files" })
            vim.keymap.set("n", "<space>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "Switch Buffer" })
            vim.keymap.set("n", "<space>/", "<cmd>Telescope live_grep<cr>", { desc = "Search" })
            vim.keymap.set({ "n", "x" }, "<space>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
          EOB
        `,
      );
    },
    after: async ({ denops }) => {
      await execute(
        denops,
        `
            lua << EOB
              local actions = require("telescope.actions")
              local trouble = require("trouble.providers.telescope")

              local telescope = require("telescope")
              local borderless = false

              telescope.setup({
                defaults = {
                  layout_strategy = "horizontal",
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
                      { "~/src", max_depth = 4 },
                    },
                  },
                },
              })

              telescope.load_extension("file_browser")
              telescope.load_extension("project")
              -- telescope.load_extension("projects")
              telescope.load_extension("vim_bookmarks")
            EOB
          `,
      );
    },
  },
];
