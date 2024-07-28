// =============================================================================
// File        : nvimtree.ts
// Author      : yukimemi
// Last Change : 2024/03/30 17:39:27.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";

import { pluginStatus } from "../pluginstatus.ts";

export const nvimtree: Plug[] = [
  {
    url: "https://github.com/nvim-tree/nvim-tree.lua",
    enabled: !pluginStatus.vscode && pluginStatus.nvimtree,
    dependencies: [
      { url: "https://github.com/nvim-tree/nvim-web-devicons" },
    ],
    afterFile: `~/.config/nvim/rc/after/nvim-tree.lua`,
  },
];
