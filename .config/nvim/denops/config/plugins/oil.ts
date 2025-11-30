// =============================================================================
// File        : oil.ts
// Author      : yukimemi
// Last Change : 2025/12/01 00:52:31.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import { pluginStatus } from "../pluginstatus.ts";

export const oil: Plug[] = [
  {
    url: "https://github.com/stevearc/oil.nvim",
    enabled: pluginStatus.oil,
    profiles: ["filer"],
    dependencies: [
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    afterFile: "~/.config/nvim/rc/after/oil.lua",
  },
];
