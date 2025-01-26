// =============================================================================
// File        : care.ts
// Author      : yukimemi
// Last Change : 2025/01/26 11:37:52.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.1.0";

export const care: Plug[] = [
  {
    url: "https://github.com/max397574/care.nvim",
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/care.lua`,
  },
];
