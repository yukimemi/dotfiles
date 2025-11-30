// =============================================================================
// File        : deck.ts
// Author      : yukimemi
// Last Change : 2025/12/01 00:48:47.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const deck: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-deck",
    profiles: ["ff"],
    dependencies: ["https://github.com/yukimemi/chronicle.vim"],
    cache: { afterFile: "~/.config/nvim/rc/after/nvim-deck.lua" },
  },
  {
    url: "https://github.com/yukimemi/deck-source-chronicle",
    profiles: ["ff"],
    dependencies: ["https://github.com/hrsh7th/nvim-deck"],
    cache: { afterFile: "~/.config/nvim/rc/after/deck-source-chronicle.lua" },
  },
];
