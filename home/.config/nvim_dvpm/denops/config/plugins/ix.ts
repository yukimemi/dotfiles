// =============================================================================
// File        : ix.ts
// Author      : yukimemi
// Last Change : 2026/01/17 21:51:46.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { selections } from "../pluginstatus.ts";

export const ix: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-cmp-kit",
    enabled: selections.completion === "ix",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/nvim-ix",
    enabled: selections.completion === "ix",
    profiles: ["completion"],
    dependencies: [
      "https://github.com/hrsh7th/nvim-cmp-kit",
      "https://github.com/hrsh7th/vim-vsnip",
    ],
    afterFile: `~/.config/nvim/rc/after/nvim-ix.lua`,
  },
];
