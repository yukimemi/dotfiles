// =============================================================================
// File        : snacks.ts
// Author      : yukimemi
// Last Change : 2025/01/19 13:54:33.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.0.2";

export const snacks: Plug[] = [
  {
    url: "https://github.com/folke/snacks.nvim",
    profiles: ["default"],
    cache: {
      afterFile: `~/.config/nvim/rc/after/snacks.lua`,
    },
  },
];
