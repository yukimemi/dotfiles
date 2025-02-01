// =============================================================================
// File        : yazi.ts
// Author      : yukimemi
// Last Change : 2025/01/26 23:01:22.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.0";

import * as fn from "jsr:@denops/std@7.4.0/function";
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
      if (info.isUpdate && info.isLoad && (await fn.executable(denops, "ya")) < 1) {
        await execCommand(denops, "cargo", ["install", "yazi-cli"]);
      }
      if (info.isUpdate && info.isLoad && (await fn.executable(denops, "yazi")) < 1) {
        await execCommand(denops, "cargo", ["install", "yazi-fm"]);
      }
    },
  },
];
