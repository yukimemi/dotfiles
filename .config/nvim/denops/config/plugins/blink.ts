// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2024/10/12 20:43:24.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.7";

export const blink: Plug[] = [
  {
    url: "https://github.com/Saghen/blink.cmp",
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.lua`,
  },
];
