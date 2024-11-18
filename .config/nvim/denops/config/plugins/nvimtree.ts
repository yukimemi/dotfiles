// =============================================================================
// File        : nvimtree.ts
// Author      : yukimemi
// Last Change : 2024/10/01 23:58:45.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.1.2";

import { pluginStatus } from "../pluginstatus.ts";

export const nvimtree: Plug[] = [
  {
    url: "https://github.com/nvim-tree/nvim-tree.lua",
    enabled: pluginStatus.nvimtree,
    dependencies: [
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    afterFile: `~/.config/nvim/rc/after/nvim-tree.lua`,
  },
];
