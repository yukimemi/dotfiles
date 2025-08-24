// =============================================================================
// File        : ix.ts
// Author      : yukimemi
// Last Change : 2025/08/03 14:39:52.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.0";

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
