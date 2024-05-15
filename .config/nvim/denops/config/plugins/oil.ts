// =============================================================================
// File        : oil.ts
// Author      : yukimemi
// Last Change : 2024/03/30 14:51:20.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.12.0/mod.ts";

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
