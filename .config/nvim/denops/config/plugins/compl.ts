// =============================================================================
// File        : compl.ts
// Author      : yukimemi
// Last Change : 2025/01/26 11:38:45.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.1.0";

export const compl: Plug[] = [
  {
    url: "https://github.com/brianaung/compl.nvim",
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/compl.lua`,
  },
];
