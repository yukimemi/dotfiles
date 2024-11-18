// =============================================================================
// File        : telescope.ts
// Author      : yukimemi
// Last Change : 2024/10/13 12:41:32.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.2.2";

export const telescope: Plug[] = [
  {
    url: "https://github.com/nvim-telescope/telescope-file-browser.nvim",
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("telescope").load_extension("file_browser")`);
    },
  },
  {
    url: "https://github.com/nvim-telescope/telescope-project.nvim",
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("telescope").load_extension("project")`);
    },
  },
  {
    url: "https://github.com/fdschmidt93/telescope-egrepify.nvim",
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-telescope/telescope.nvim",
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("telescope").load_extension("egrepify")`);
    },
  },
  {
    url: "https://github.com/tom-anders/telescope-vim-bookmarks.nvim",
    enabled: false,
    dependencies: [
      "https://github.com/MattesGroeger/vim-bookmarks",
      "https://github.com/nvim-telescope/telescope.nvim",
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("telescope").load_extension("vim_bookmarks")`);
    },
  },
  {
    url: "https://github.com/nvim-telescope/telescope-symbols.nvim",
  },
  {
    url: "https://github.com/nvim-telescope/telescope.nvim",
    cache: {
      beforeFile: "~/.config/nvim/rc/before/telescope.lua",
      afterFile: "~/.config/nvim/rc/after/telescope.lua",
    },
    dependencies: [
      "https://github.com/folke/trouble.nvim",
      "https://github.com/nvim-telescope/telescope-symbols.nvim",
      "https://github.com/nvim-telescope/telescope-file-browser.nvim",
      "https://github.com/nvim-telescope/telescope-project.nvim",
      "https://github.com/fdschmidt93/telescope-egrepify.nvim",
      // "https://github.com/tom-anders/telescope-vim-bookmarks.nvim",
    ],
  },
];
