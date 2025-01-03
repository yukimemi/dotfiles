// =============================================================================
// File        : yazi.ts
// Author      : yukimemi
// Last Change : 2025/01/02 21:46:38.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.0.2";

import { pluginStatus } from "../pluginstatus.ts";
import { execCommand } from "../util.ts";

export const yazi: Plug[] = [
  {
    url: "https://github.com/mikavilpas/yazi.nvim",
    profiles: ["minimal"],
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    enabled: pluginStatus.yazi,
    cache: { afterFile: `~/.config/nvim/rc/after/yazi.lua` },
    build: async ({ denops, info }) => {
      if (info.isUpdate && info.isLoad) {
        await execCommand(denops, "cargo", ["install", "yazi-fm", "yazi-cli"]);
      }
    },
  },
];
