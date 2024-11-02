// =============================================================================
// File        : oil.ts
// Author      : yukimemi
// Last Change : 2024/10/02 00:01:25.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.12";

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
