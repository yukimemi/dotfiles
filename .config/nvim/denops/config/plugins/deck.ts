// =============================================================================
// File        : deck.ts
// Author      : yukimemi
// Last Change : 2025/01/26 19:27:52.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.0";

export const deck: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-deck",
    dependencies: ["https://github.com/yukimemi/chronicle.vim"],
    profiles: ["default"],
    cache: { afterFile: "~/.config/nvim/rc/after/nvim-deck.lua" },
  },
  {
    url: "https://github.com/yukimemi/deck-source-chronicle",
    dependencies: ["https://github.com/hrsh7th/nvim-deck"],
    profiles: ["default"],
    cache: { afterFile: "~/.config/nvim/rc/after/deck-source-chronicle.lua" },
  },
];
