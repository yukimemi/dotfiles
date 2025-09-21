// =============================================================================
// File        : oil.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:12:51.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

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
