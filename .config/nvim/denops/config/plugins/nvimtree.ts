// =============================================================================
// File        : nvimtree.ts
// Author      : yukimemi
// Last Change : 2026/01/17 21:58:46.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import { selections } from "../pluginstatus.ts";

export const nvimtree: Plug[] = [
  {
    url: "https://github.com/nvim-tree/nvim-tree.lua",
    enabled: selections.filer === "nvimtree",
    profiles: ["filer"],
    dependencies: [
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    cache: { afterFile: `~/.config/nvim/rc/after/nvim-tree.lua` },
  },
];
