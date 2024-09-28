// =============================================================================
// File        : oil.ts
// Author      : yukimemi
// Last Change : 2024/03/30 14:51:20.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.2.0";

import { pluginStatus } from "../pluginstatus.ts";

export const oil: Plug[] = [
  {
    url: "https://github.com/stevearc/oil.nvim",
    enabled: !pluginStatus.vscode && pluginStatus.oil,
    dependencies: [
      { url: "https://github.com/nvim-tree/nvim-web-devicons" },
    ],
    afterFile: "~/.config/nvim/rc/after/oil.lua",
  },
];
