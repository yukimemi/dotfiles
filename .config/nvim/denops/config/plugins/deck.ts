// =============================================================================
// File        : deck.ts
// Author      : yukimemi
// Last Change : 2024/11/26 21:23:00.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.4.1";

export const deck: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-deck",
    rev: "dev",
    cache: { afterFile: "~/.config/nvim/rc/after/nvim-deck.lua" },
  },
];
