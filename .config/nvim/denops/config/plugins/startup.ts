// =============================================================================
// File        : startup.ts
// Author      : yukimemi
// Last Change : 2024/04/07 08:52:28.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.12.0/mod.ts";

export const startup: Plug[] = [
  {
    url: "https://github.com/goolord/alpha-nvim",
    clone: false,
    cache: {
      after: `
        lua require("alpha").setup(require("alpha.themes.startify").config)
      `,
    },
  },
  {
    url: "https://github.com/startup-nvim/startup.nvim",
    clone: false,
    cache: {
      after: `
        lua require("startup").setup({theme = "startify"})
      `,
    },
  },
  {
    url: "https://github.com/willothy/veil.nvim",
    clone: false,
    cache: {
      afterFile: "~/.config/nvim/rc/after/veil.lua",
    },
  },
  {
    url: "https://github.com/ChuyB/billboard.nvim",
    clone: false,
    cache: {
      enabled: false,
      afterFile: "~/.config/nvim/rc/after/billboard.lua",
    },
  },
];
