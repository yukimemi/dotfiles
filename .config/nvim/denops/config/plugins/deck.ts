// =============================================================================
// File        : deck.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:15:23.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const deck: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-deck",
    dependencies: ["https://github.com/yukimemi/chronicle.vim"],
    profiles: ["minimal"],
    cache: { afterFile: "~/.config/nvim/rc/after/nvim-deck.lua" },
  },
  {
    url: "https://github.com/yukimemi/deck-source-chronicle",
    dependencies: ["https://github.com/hrsh7th/nvim-deck"],
    profiles: ["minimal"],
    cache: { afterFile: "~/.config/nvim/rc/after/deck-source-chronicle.lua" },
  },
];
