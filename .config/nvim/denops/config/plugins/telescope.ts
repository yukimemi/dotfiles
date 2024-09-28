// =============================================================================
// File        : telescope.ts
// Author      : yukimemi
// Last Change : 2024/09/16 11:27:06.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.2.0";

export const telescope: Plug[] = [
  {
    url: "https://github.com/nvim-telescope/telescope.nvim",
    cache: {
      beforeFile: "~/.config/nvim/rc/before/telescope.lua",
      afterFile: "~/.config/nvim/rc/after/telescope.lua",
    },
    dependencies: [
      {
        url: "https://github.com/folke/which-key.nvim",
        enabled: false,
      },
      {
        url: "https://github.com/folke/trouble.nvim",
        enabled: false,
      },
      { url: "https://github.com/nvim-telescope/telescope-symbols.nvim" },
      {
        url: "https://github.com/nvim-telescope/telescope-file-browser.nvim",
        dependencies: [{ url: "https://github.com/nvim-telescope/telescope.nvim" }],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("telescope").load_extension("file_browser")`);
        },
      },
      {
        url: "https://github.com/nvim-telescope/telescope-project.nvim",
        dependencies: [{ url: "https://github.com/nvim-telescope/telescope.nvim" }],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("telescope").load_extension("project")`);
        },
      },
      {
        url: "https://github.com/fdschmidt93/telescope-egrepify.nvim",
        dependencies: [{ url: "https://github.com/nvim-lua/plenary.nvim" }, {
          url: "https://github.com/nvim-telescope/telescope.nvim",
        }],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("telescope").load_extension("egrepify")`);
        },
      },
      {
        url: "https://github.com/tom-anders/telescope-vim-bookmarks.nvim",
        enabled: false,
        dependencies: [{ url: "https://github.com/MattesGroeger/vim-bookmarks" }, {
          url: "https://github.com/nvim-telescope/telescope.nvim",
        }],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("telescope").load_extension("vim_bookmarks")`);
        },
      },
    ],
  },
];
