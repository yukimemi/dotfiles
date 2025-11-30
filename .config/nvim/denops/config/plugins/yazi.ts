// =============================================================================
// File        : yazi.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:09:46.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as fn from "@denops/std/function";
import { pluginStatus } from "../pluginstatus.ts";
import { execCommand } from "../util.ts";

export const yazi: Plug[] = [
  {
    url: "https://github.com/mikavilpas/yazi.nvim",
    enabled: pluginStatus.yazi,
    profiles: ["filer"],
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    cache: { afterFile: `~/.config/nvim/rc/after/yazi.lua` },
    build: async ({ denops, info }) => {
      if (
        info.isUpdate && info.isLoad && (await fn.executable(denops, "ya")) < 1
      ) {
        await execCommand(denops, "cargo", ["install", "yazi-cli"]);
      }
      if (
        info.isUpdate && info.isLoad &&
        (await fn.executable(denops, "yazi")) < 1
      ) {
        await execCommand(denops, "cargo", ["install", "yazi-fm"]);
      }
    },
  },
];
