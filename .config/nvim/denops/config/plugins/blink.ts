// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2025/09/14 07:07:55.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";

export const blink: Plug[] = [
  {
    url: "https://github.com/saghen/blink.download",
    profiles: ["core"],
  },
  {
    url: "https://github.com/saghen/blink.cmp",
    rev: "v1.6.0",
    profiles: ["completion", "core"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.cmp.lua`,
  },
  {
    url: "https://github.com/saghen/blink.pairs",
    rev: "v0.3.0",
    profiles: ["default", "core"],
    dependencies: ["https://github.com/saghen/blink.download"],
    afterFile: "~/.config/nvim/rc/after/blink.pairs.lua",
  },
];
