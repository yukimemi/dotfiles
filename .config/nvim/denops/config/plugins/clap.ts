// =============================================================================
// File        : clap.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:18:17.
// =============================================================================

import * as fn from "@denops/std/function";
import type { Plug } from "@yukimemi/dvpm";
import { execCommand } from "../util.ts";

export const clap: Plug[] = [
  {
    url: "https://github.com/liuchengxu/vim-clap",
    profiles: ["ff"],
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
    afterFile: "~/.config/nvim/rc/after/vim-clap.vim",
  },
];
