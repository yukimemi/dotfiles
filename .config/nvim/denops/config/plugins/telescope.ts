// =============================================================================
// File        : telescope.ts
// Author      : yukimemi
// Last Change : 2025/02/01 13:35:38.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.0";
import { pluginStatus } from "../pluginstatus.ts";

export const telescope: Plug[] = [
  {
    url: "https://github.com/yukimemi/telescope-chronicle.nvim",
    profiles: ["default"],
    dependencies: [
      "https://github.com/nvim-telescope/telescope.nvim",
      "https://github.com/yukimemi/chronicle.vim",
    ],
    cache: {
      afterFile: "~/.config/nvim/rc/after/telescope-chronicle.lua",
    },
  },
  {
    url: "https://github.com/nvim-telescope/telescope-frecency.nvim",
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
    afterFile: "~/.config/nvim/rc/after/telescope-frecency.lua",
  },
  {
    url: "https://github.com/nvim-telescope/telescope-file-browser.nvim",
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
    afterFile: "~/.config/nvim/rc/after/telescope-file-browser.lua",
  },
  {
    url: "https://github.com/nvim-telescope/telescope-project.nvim",
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
    afterFile: "~/.config/nvim/rc/after/telescope-project.lua",
  },
  {
    url: "https://github.com/fdschmidt93/telescope-egrepify.nvim",
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
    cache: {
      afterFile: "~/.config/nvim/rc/after/telescope-egrepify.lua",
    },
  },
  {
    url: "https://github.com/tom-anders/telescope-vim-bookmarks.nvim",
    enabled: pluginStatus.vimbookmarks,
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
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
  },
  {
    url: "https://github.com/nvim-telescope/telescope.nvim",
    profiles: ["minimal"],
    cache: {
      afterFile: "~/.config/nvim/rc/after/telescope.lua",
    },
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/folke/trouble.nvim",
    ],
  },
];
