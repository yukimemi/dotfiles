// =============================================================================
// File        : nvimtree.ts
// Author      : yukimemi
// Last Change : 2024/10/01 23:58:45.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.0";

import { pluginStatus } from "../pluginstatus.ts";

export const nvimtree: Plug[] = [
  {
    url: "https://github.com/nvim-tree/nvim-tree.lua",
    profiles: ["filer"],
    enabled: pluginStatus.nvimtree,
    dependencies: [
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    cache: { afterFile: `~/.config/nvim/rc/after/nvim-tree.lua` },
  },
];
