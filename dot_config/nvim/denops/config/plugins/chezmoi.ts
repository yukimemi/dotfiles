// =============================================================================
// File        : chezmoi.ts
// Author      : yukimemi
// Last Change : 2026/02/19 09:05:42.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const chezmoi: Plug[] = [
  {
    url: "https://github.com/xvzc/chezmoi.nvim",
    enabled: false,
    profiles: ["core"],
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
    ],
    cache: {
      afterFile: "~/.config/nvim/rc/after/chezmoi.lua",
    },
  },
  {
    url: "https://github.com/alker0/chezmoi.vim",
    profiles: ["core"],
    lazy: {
      event: "BufRead",
    },
  },
];
