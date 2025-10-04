// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2025/10/04 21:40:52.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { join } from "@std/path";
import { exists } from "@std/fs";

export const blink: Plug[] = [
  {
    url: "https://github.com/saghen/blink.download",
    profiles: ["core"],
  },
  {
    url: "https://github.com/saghen/blink.cmp",
    rev: "v1.7.0",
    profiles: ["completion", "core"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.cmp.lua`,
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
  },
  {
    url: "https://github.com/saghen/blink.pairs",
    rev: "v0.3.0",
    profiles: ["default"],
    dependencies: ["https://github.com/saghen/blink.download"],
    afterFile: "~/.config/nvim/rc/after/blink.pairs.lua",
  },
  {
    url: "https://github.com/Saghen/blink.indent",
    profiles: ["default", "core"],
    afterFile: "~/.config/nvim/rc/after/blink.indent.lua",
  },
];
