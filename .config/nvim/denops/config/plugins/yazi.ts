// =============================================================================
// File        : yazi.ts
// Author      : yukimemi
// Last Change : 2024/12/31 10:21:24.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.7.0";

import { pluginStatus } from "../pluginstatus.ts";
import { execCommand } from "../util.ts";

export const yazi: Plug[] = [
  {
    url: "https://github.com/mikavilpas/yazi.nvim",
    profiles: ["minimal"],
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    enabled: pluginStatus.yazi,
    cache: { afterFile: `~/.config/nvim/rc/after/yazi.lua` },
    build: async ({ denops }) => {
      await execCommand(denops, "cargo", ["install", "yazi-fm", "yazi-cli"]);
    },
  },
];
