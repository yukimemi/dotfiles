// =============================================================================
// File        : nvimtree.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:12:56.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

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
