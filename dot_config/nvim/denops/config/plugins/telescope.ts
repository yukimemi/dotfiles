// =============================================================================
// File        : telescope.ts
// Author      : yukimemi
// Last Change : 2026/01/17 22:53:10.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus, selections } from "../pluginstatus.ts";

export const telescope: Plug[] = [
  {
    url: "https://github.com/yukimemi/telescope-chronicle.nvim",
    enabled: selections.ff === "telescope",
    profiles: ["ff"],
    lazy: {
      cmd: "Telescope",
    },
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
    enabled: selections.ff === "telescope",
    profiles: ["ff"],
    lazy: {
      cmd: "Telescope",
    },
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
    afterFile: "~/.config/nvim/rc/after/telescope-frecency.lua",
  },
  {
    url: "https://github.com/nvim-telescope/telescope-file-browser.nvim",
    enabled: selections.ff === "telescope",
    profiles: ["ff"],
    lazy: {
      cmd: "Telescope",
    },
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
    afterFile: "~/.config/nvim/rc/after/telescope-file-browser.lua",
  },
  {
    url: "https://github.com/nvim-telescope/telescope-project.nvim",
    enabled: selections.ff === "telescope",
    profiles: ["ff"],
    lazy: {
      cmd: "Telescope",
    },
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
    afterFile: "~/.config/nvim/rc/after/telescope-project.lua",
  },
  {
    url: "https://github.com/fdschmidt93/telescope-egrepify.nvim",
    enabled: selections.ff === "telescope",
    profiles: ["ff"],
    lazy: {
      cmd: "Telescope",
    },
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
    cache: {
      afterFile: "~/.config/nvim/rc/after/telescope-egrepify.lua",
    },
  },
  {
    url: "https://github.com/tom-anders/telescope-vim-bookmarks.nvim",
    enabled: selections.ff === "telescope" && pluginStatus.vimbookmarks,
    profiles: ["ff"],
    lazy: {
      cmd: "Telescope",
    },
    dependencies: [
      "https://github.com/MattesGroeger/vim-bookmarks",
      "https://github.com/nvim-telescope/telescope.nvim",
    ],
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("telescope").load_extension("vim_bookmarks")`,
      );
    },
  },
  {
    url: "https://github.com/nvim-telescope/telescope-symbols.nvim",
    enabled: selections.ff === "telescope",
    profiles: ["ff"],
    lazy: {
      cmd: "Telescope",
    },
    dependencies: ["https://github.com/nvim-telescope/telescope.nvim"],
  },
  {
    url: "https://github.com/nvim-telescope/telescope.nvim",
    enabled: selections.ff === "telescope",
    profiles: ["ff"],
    lazy: {
      cmd: "Telescope",
    },
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/folke/trouble.nvim",
    ],
    cache: { afterFile: "~/.config/nvim/rc/after/telescope.lua" },
  },
];
