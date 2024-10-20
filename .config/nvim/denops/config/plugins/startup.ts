// =============================================================================
// File        : startup.ts
// Author      : yukimemi
// Last Change : 2024/10/12 22:00:44.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.9";

export const startup: Plug[] = [
  {
    url: "https://github.com/goolord/alpha-nvim",
    dependencies: ["https://github.com/nvim-tree/nvim-web-devicons"],
    clone: false,
    cache: {
      afterFile: `~/.config/nvim/rc/after/alpha-nvim.lua`,
    },
  },
  {
    url: "https://github.com/startup-nvim/startup.nvim",
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
  {
    url: "https://github.com/folke/drop.nvim",
    afterFile: "~/.config/nvim/rc/after/drop.lua",
  },
];
