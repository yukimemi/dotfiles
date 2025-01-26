// =============================================================================
// File        : oil.ts
// Author      : yukimemi
// Last Change : 2025/01/26 11:38:58.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.1.0";

import { pluginStatus } from "../pluginstatus.ts";

export const oil: Plug[] = [
  {
    url: "https://github.com/stevearc/oil.nvim",
    enabled: pluginStatus.oil,
    dependencies: [
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    afterFile: "~/.config/nvim/rc/after/oil.lua",
  },
];
