// =============================================================================
// File        : oil.ts
// Author      : yukimemi
// Last Change : 2026/01/17 22:39:39.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import { selections } from "../pluginstatus.ts";

export const oil: Plug[] = [
  {
    url: "https://github.com/stevearc/oil.nvim",
    enabled: selections.filer === "oil",
    profiles: ["filer"],
    dependencies: [
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    afterFile: "~/.config/nvim/rc/after/oil.lua",
  },
];
