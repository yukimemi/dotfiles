// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2025/08/24 21:37:58.
// =============================================================================

import { join } from "jsr:@std/path@1.1.2/join";
import { exists } from "jsr:@std/fs@1.0.19";
import type { Plug } from "jsr:@yukimemi/dvpm@7.1.0";
import { execCommand } from "../util.ts";

export const blink: Plug[] = [
  {
    url: "https://github.com/Saghen/blink.cmp",
    profiles: ["completion"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.cmp.lua`,
    build: async ({ denops, info }) => {
      if (info.isLoad && info.isUpdate) {
        if (denops.meta.platform !== "windows") {
          return await execCommand(denops, "cargo", ["build", "--release"], info.dst);
        }
        const targetDir = join(info.dst, "target", "release");
        const dllPath = join(targetDir, "blink_cmp_fuzzy.dll");
        const oldDllPath = join(targetDir, "blink_cmp_fuzzy.dll.old");
        const tempBuildDir = await Deno.makeTempDir();
        const tempDllPath = join(tempBuildDir, "release", "blink_cmp_fuzzy.dll");
        await execCommand(
          denops,
          "rustup",
          ["run", "nightly", "cargo", "build", "--release", `--target-dir=${tempBuildDir}`],
          info.dst,
        );
        if (!(await exists(tempDllPath))) {
          throw "Build failed ... (blink.cmp)";
        }
        if (await exists(dllPath)) {
          await Deno.rename(dllPath, oldDllPath);
        }
        await Deno.copyFile(tempDllPath, dllPath);
      }
    },
  },
  {
    url: "https://github.com/Saghen/blink.pairs",
    profiles: ["default"],
    afterFile: "~/.config/nvim/rc/after/blink.pairs.lua",
    build: async ({ denops, info }) => {
      if (info.isLoad && info.isUpdate) {
        await execCommand(denops, "cargo", ["build", "--release"], info.dst);
      }
    },
  },
];
