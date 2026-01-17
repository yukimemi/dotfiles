// =============================================================================
// File        : deck.ts
// Author      : yukimemi
// Last Change : 2026/01/17 21:49:51.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { selections } from "../pluginstatus.ts";

export const deck: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-deck",
    enabled: selections.ff === "deck",
    profiles: ["ff"],
    dependencies: ["https://github.com/yukimemi/chronicle.vim"],
    cache: { afterFile: "~/.config/nvim/rc/after/nvim-deck.lua" },
  },
  {
    url: "https://github.com/yukimemi/deck-source-chronicle",
    enabled: selections.ff === "deck",
    profiles: ["ff"],
    dependencies: ["https://github.com/hrsh7th/nvim-deck"],
    cache: { afterFile: "~/.config/nvim/rc/after/deck-source-chronicle.lua" },
  },
];
