// =============================================================================
// File        : deck.ts
// Author      : yukimemi
// Last Change : 2025/01/26 11:39:40.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.1.1";

export const deck: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-deck",
    dependencies: ["https://github.com/yukimemi/chronicle.vim"],
    profiles: ["default"],
    cache: { afterFile: "~/.config/nvim/rc/after/nvim-deck.lua" },
  },
];
