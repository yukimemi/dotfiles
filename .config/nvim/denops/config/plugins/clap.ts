// =============================================================================
// File        : clap.ts
// Author      : yukimemi
// Last Change : 2025/01/02 01:55:07.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.0.2";
import * as fn from "jsr:@denops/std@7.4.0/function";
import { execCommand } from "../util.ts";

export const clap: Plug[] = [
  {
    url: "https://github.com/liuchengxu/vim-clap",
    afterFile: "~/.config/nvim/rc/after/vim-clap.vim",
    build: async ({ denops, info }) => {
      if (info.isUpdate && info.isLoad) {
        if (!(await fn.executable(denops, `fd`))) {
          await execCommand(denops, "cargo", ["install", "fd-find"]);
        }
        if (!(await fn.executable(denops, `rg`))) {
          await execCommand(denops, "cargo", ["install", "ripgrep"]);
        }
        // await execCommand("cargo", ["build", "--release"], info.dst);
        await denops.call(`clap#installer#download_binary`);
      }
    },
  },
];
