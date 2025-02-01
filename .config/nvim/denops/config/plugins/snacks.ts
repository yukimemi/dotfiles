// =============================================================================
// File        : snacks.ts
// Author      : yukimemi
// Last Change : 2025/01/26 11:38:46.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.2";

export const snacks: Plug[] = [
  {
    url: "https://github.com/folke/snacks.nvim",
    profiles: ["default"],
    cache: {
      afterFile: `~/.config/nvim/rc/after/snacks.lua`,
    },
  },
];
