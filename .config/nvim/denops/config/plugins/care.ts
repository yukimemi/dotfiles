// =============================================================================
// File        : care.ts
// Author      : yukimemi
// Last Change : 2025/01/02 21:46:34.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.0.2";

export const care: Plug[] = [
  {
    url: "https://github.com/max397574/care.nvim",
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/care.lua`,
  },
];
