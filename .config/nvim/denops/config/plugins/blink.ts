// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2024/10/14 18:48:14.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.10";

export const blink: Plug[] = [
  {
    url: "https://github.com/Saghen/blink.cmp",
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.lua`,
    build: async ({ info }) => {
      if (!info.isLoad || !info.isUpdate) {
        return;
      }
      const build = async (command: string, args: string[]) => {
        console.log(`blink.cmp build start: "${command}" "${args.join(" ")}"`);
        const cmd = new Deno.Command(command, { args, cwd: info.dst });
        const output = await cmd.output();
        if (output.stdout.length) {
          console.log(new TextDecoder().decode(output.stdout));
        }
        if (output.stderr.length) {
          console.error(new TextDecoder().decode(output.stderr));
        }
      };
      await build("cargo", ["build", "--release"]);
    },
  },
];
