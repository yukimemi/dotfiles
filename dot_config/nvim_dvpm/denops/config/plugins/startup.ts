// =============================================================================
// File        : startup.ts
// Author      : yukimemi
// Last Change : 2026/01/18 01:39:05.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const startup: Plug[] = [
  {
    url: "https://github.com/goolord/alpha-nvim",
    profiles: ["startup"],
    dependencies: ["https://github.com/nvim-tree/nvim-web-devicons"],
    clone: false,
    cache: {
      afterFile: `~/.config/nvim/rc/after/alpha-nvim.lua`,
    },
  },
  {
    url: "https://github.com/startup-nvim/startup.nvim",
    profiles: ["startup"],
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    clone: false,
    cache: {
      after: `
        lua require("startup").setup({theme = "dashboard"})
      `,
    },
  },
  {
    url: "https://github.com/willothy/veil.nvim",
    profiles: ["startup"],
    clone: false,
    cache: {
      afterFile: "~/.config/nvim/rc/after/veil.lua",
    },
  },
  {
    url: "https://github.com/ChuyB/billboard.nvim",
    profiles: ["startup"],
    clone: false,
    cache: {
      enabled: false,
      afterFile: "~/.config/nvim/rc/after/billboard.lua",
    },
  },
  {
    url: "https://github.com/dstein64/vim-startuptime",
    profiles: ["core"],
    lazy: {
      cmd: "StartupTime",
    },
  },
  {
    url: "https://github.com/thinca/vim-singleton",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
    profiles: ["core"],
    cache: {
      after: `call singleton#enable()`,
    },
  },
];
