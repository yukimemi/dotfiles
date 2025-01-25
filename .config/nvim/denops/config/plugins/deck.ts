// =============================================================================
// File        : deck.ts
// Author      : yukimemi
// Last Change : 2025/01/25 15:14:03.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.1.0";

export const deck: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-deck",
    profiles: ["default"],
    cache: { afterFile: "~/.config/nvim/rc/after/nvim-deck.lua" },
  },
];
