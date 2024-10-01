// =============================================================================
// File        : nvimtree.ts
// Author      : yukimemi
// Last Change : 2024/03/30 17:39:27.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.7";

import { pluginStatus } from "../pluginstatus.ts";

export const nvimtree: Plug[] = [
  {
    url: "https://github.com/nvim-tree/nvim-tree.lua",
    enabled: !pluginStatus.vscode && pluginStatus.nvimtree,
    dependencies: [
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    afterFile: `~/.config/nvim/rc/after/nvim-tree.lua`,
  },
];
