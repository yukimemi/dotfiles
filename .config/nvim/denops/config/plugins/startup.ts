// =============================================================================
// File        : startup.ts
// Author      : yukimemi
// Last Change : 2023/12/30 20:52:46.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.7.0/mod.ts";

export const startup: Plug[] = [
  {
    url: "https://github.com/goolord/alpha-nvim",
    enabled: false,
    clone: false,
    cache: {
      after: `
        lua require("alpha").setup(require("alpha.themes.startify").config)
      `,
    },
  },
  {
    url: "https://github.com/startup-nvim/startup.nvim",
    enabled: false,
    clone: false,
    cache: {
      after: `
        lua require("startup").setup({theme = "startify"})
      `,
    },
  },
  {
    url: "https://github.com/willothy/veil.nvim",
    enabled: false,
    clone: false,
    cache: {
      afterFile: "~/.config/nvim/rc/after/veil.lua",
    },
  },
];
