// =============================================================================
// File        : compl.ts
// Author      : yukimemi
// Last Change : 2024/12/09 02:14:22.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.5.2";

export const compl: Plug[] = [
  {
    url: "https://github.com/brianaung/compl.nvim",
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/compl.lua`,
  },
];
