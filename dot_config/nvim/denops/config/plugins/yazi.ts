// =============================================================================
// File        : yazi.ts
// Author      : yukimemi
// Last Change : 2026/01/17 23:00:29.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as fn from "@denops/std/function";
import { selections } from "../pluginstatus.ts";
import { execCommand } from "../util.ts";

export const yazi: Plug[] = [
  {
    url: "https://github.com/mikavilpas/yazi.nvim",
    enabled: selections.filer === "yazi",
    profiles: ["filer"],
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    cache: { afterFile: `~/.config/nvim/rc/after/yazi.lua` },
    build: async ({ denops, info }) => {
      if (
        (info.isInstalled || info.isUpdated) && info.isLoaded &&
        (await fn.executable(denops, "ya")) < 1
      ) {
        await execCommand(denops, "cargo", ["install", "yazi-cli"]);
      }
      if (
        (info.isInstalled || info.isUpdated) && info.isLoaded &&
        (await fn.executable(denops, "yazi")) < 1
      ) {
        await execCommand(denops, "cargo", ["install", "yazi-fm"]);
      }
    },
  },
];
