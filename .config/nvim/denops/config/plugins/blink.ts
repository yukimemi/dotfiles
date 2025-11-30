// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2025/12/01 00:42:08.
// =============================================================================

import { exists } from "@std/fs";
import { join } from "@std/path";
import type { Plug } from "@yukimemi/dvpm";

export const blink: Plug[] = [
  {
    url: "https://github.com/saghen/blink.download",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/mikavilpas/blink-ripgrep.nvim",
    profiles: ["completion"],
    rev: "v2.2.0",
  },
  {
    url: "https://github.com/saghen/blink.cmp",
    profiles: ["completion"],
    dependencies: [
      "https://github.com/rafamadriz/friendly-snippets",
      "https://github.com/mikavilpas/blink-ripgrep.nvim",
    ],
    rev: "v1.7.0",
    build: async ({ denops, info }) => {
      if (info.isLoad && info.isUpdate) {
        if (denops.meta.platform !== "windows") {
          return;
        }
        const dlls = ["libblink_cmp_fuzzy.dll", "blink_cmp_fuzzy.dll"];
        await Promise.all(dlls.map(async (dll) => {
          const targetDir = join(info.dst, "target", "release");
          const dllPath = join(targetDir, dll);
          if (await exists(dllPath)) {
            const oldDllPath = join(targetDir, `${dll}.${(new Date().getTime())}`);
            await Deno.rename(dllPath, oldDllPath);
          }
        }));
      }
    },
    afterFile: `~/.config/nvim/rc/after/blink.cmp.lua`,
  },
  {
    url: "https://github.com/saghen/blink.pairs",
    enabled: false,
    profiles: ["completion"],
    dependencies: ["https://github.com/saghen/blink.download"],
    rev: "v0.3.0",
    afterFile: "~/.config/nvim/rc/after/blink.pairs.lua",
  },
  {
    url: "https://github.com/Saghen/blink.indent",
    enabled: false,
    profiles: ["core"],
    afterFile: "~/.config/nvim/rc/after/blink.indent.lua",
  },
];
