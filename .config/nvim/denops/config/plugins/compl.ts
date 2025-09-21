// =============================================================================
// File        : compl.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:16:39.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const compl: Plug[] = [
  {
    url: "https://github.com/brianaung/compl.nvim",
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/compl.lua`,
  },
];
