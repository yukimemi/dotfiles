// =============================================================================
// File        : yazi.ts
// Author      : yukimemi
// Last Change : 2024/11/18 08:57:38.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.3.0";

import { pluginStatus } from "../pluginstatus.ts";

export const yazi: Plug[] = [
  {
    url: "https://github.com/mikavilpas/yazi.nvim",
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    enabled: pluginStatus.yazi,
    cache: { afterFile: `~/.config/nvim/rc/after/yazi.lua` },
    build: async ({ info }) => {
      if (!info.isUpdate) {
        return;
      }
      const install = async (command: string, args: string[]) => {
        const cmd = new Deno.Command(command, { args, cwd: info.dst });
        const output = await cmd.output();
        if (output.stdout.length) {
          console.log(new TextDecoder().decode(output.stdout));
        }
        if (output.stderr.length) {
          console.error(new TextDecoder().decode(output.stderr));
        }
      };
      await install("cargo", ["install", "yazi-fm", "yazi-cli"]);
    },
  },
];
