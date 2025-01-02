// =============================================================================
// File        : care.ts
// Author      : yukimemi
// Last Change : 2024/11/04 15:45:05.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.0.0";

export const care: Plug[] = [
  {
    url: "https://github.com/max397574/care.nvim",
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/care.lua`,
  },
];
