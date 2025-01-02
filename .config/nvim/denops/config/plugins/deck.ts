// =============================================================================
// File        : deck.ts
// Author      : yukimemi
// Last Change : 2024/11/26 21:23:00.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.0.1";

export const deck: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-deck",
    cache: { afterFile: "~/.config/nvim/rc/after/nvim-deck.lua" },
  },
];
