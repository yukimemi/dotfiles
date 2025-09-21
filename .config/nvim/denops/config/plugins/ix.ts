// =============================================================================
// File        : ix.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:13:59.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const ix: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-cmp-kit",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/nvim-ix",
    dependencies: [
      "https://github.com/hrsh7th/nvim-cmp-kit",
      "https://github.com/hrsh7th/vim-vsnip",
    ],
    profiles: ["completion"],
    afterFile: `~/.config/nvim/rc/after/nvim-ix.lua`,
  },
];
