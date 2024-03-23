// =============================================================================
// File        : clap.ts
// Author      : yukimemi
// Last Change : 2024/03/23 19:29:12.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.9.0/mod.ts";

import { pluginStatus } from "../pluginstatus.ts";

export const clap: Plug[] = [
  {
    url: "https://github.com/liuchengxu/vim-clap",
    enabled: pluginStatus.clap && !pluginStatus.vscode,
    afterFile: "~/.config/nvim/rc/after/vim-clap.vim",
    build: async ({ denops }) => {
      await denops.call(`clap#installer#force_download`);
      const install = async (command: string, args: string[]) => {
        const cmd = new Deno.Command(command, { args });
        const output = await cmd.output();
        console.log(new TextDecoder().decode(output.stdout));
        if (output.stderr.length) {
          console.error(new TextDecoder().decode(output.stderr));
        }
      };
      await install("cargo", ["install", "fd-find"]);
      await install("cargo", ["install", "ripgrep"]);
    },
  },
];
