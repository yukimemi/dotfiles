// =============================================================================
// File        : clap.ts
// Author      : yukimemi
// Last Change : 2024/04/20 15:56:29.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";
import * as fn from "jsr:@denops/std@7.0.0/function";

import { pluginStatus } from "../pluginstatus.ts";

export const clap: Plug[] = [
  {
    url: "https://github.com/liuchengxu/vim-clap",
    enabled: pluginStatus.clap && !pluginStatus.vscode,
    afterFile: "~/.config/nvim/rc/after/vim-clap.vim",
    build: async ({ denops, info }) => {
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
      if (!(await fn.executable(denops, `fd`))) {
        await install("cargo", ["install", "fd-find"]);
      }
      if (!(await fn.executable(denops, `rg`))) {
        await install("cargo", ["install", "ripgrep"]);
      }
      // await install("cargo", ["build", "--release"]);
      await denops.call(`clap#installer#download_binary`);
    },
  },
];
