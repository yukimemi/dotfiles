// =============================================================================
// File        : telescope.ts
// Author      : yukimemi
// Last Change : 2023/12/03 13:22:18.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.7.0/mod.ts";

export const telescope: Plug[] = [
  {
    url: "https://github.com/nvim-telescope/telescope.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    dependencies: [
      { url: "https://github.com/folke/which-key.nvim" },
      { url: "https://github.com/folke/trouble.nvim" },
      { url: "https://github.com/nvim-telescope/telescope-symbols.nvim" },
      {
        url: "https://github.com/nvim-telescope/telescope-file-browser.nvim",
        dependencies: [
          { url: "https://github.com/nvim-telescope/telescope.nvim" },
        ],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("telescope").load_extension("file_browser")`);
        },
      },
      {
        url: "https://github.com/nvim-telescope/telescope-project.nvim",
        dependencies: [
          { url: "https://github.com/nvim-telescope/telescope.nvim" },
        ],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("telescope").load_extension("project")`);
        },
      },
      {
        url: "https://github.com/fdschmidt93/telescope-egrepify.nvim",
        dependencies: [
          { url: "https://github.com/nvim-lua/plenary.nvim" },
          { url: "https://github.com/nvim-telescope/telescope.nvim" },
        ],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("telescope").load_extension("egrepify")`);
        },
      },
      {
        url: "https://github.com/tom-anders/telescope-vim-bookmarks.nvim",
        dependencies: [
          { url: "https://github.com/MattesGroeger/vim-bookmarks" },
          { url: "https://github.com/nvim-telescope/telescope.nvim" },
        ],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("telescope").load_extension("vim_bookmarks")`);
        },
      },
    ],
    beforeFile: "~/.config/nvim/rc/before/telescope.lua",
    afterFile: "~/.config/nvim/rc/after/telescope.lua",
  },
];
