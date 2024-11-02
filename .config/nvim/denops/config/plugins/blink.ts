// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2024/11/02 17:06:59.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.12";
import { notify } from "../util.ts";

export const blink: Plug[] = [
  {
    url: "https://github.com/Saghen/blink.cmp",
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.lua`,
    build: async ({ denops, info }) => {
      if (!info.isLoad || !info.isUpdate) {
        return;
      }
      const build = async (command: string, args: string[]) => {
        await notify(denops, `blink.cmp build start: "${command}" "${args.join(" ")}"`);
        const cmd = new Deno.Command(command, { args, cwd: info.dst });
        const output = await cmd.output();
        if (output.stdout.length) {
          await notify(denops, new TextDecoder().decode(output.stdout));
        }
        if (output.stderr.length) {
          await notify(denops, new TextDecoder().decode(output.stderr));
        }
      };
      await build("cargo", ["build", "--release"]);
    },
  },
];
