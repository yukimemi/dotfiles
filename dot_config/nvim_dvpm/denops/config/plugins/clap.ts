// =============================================================================
// File        : clap.ts
// Author      : yukimemi
// Last Change : 2026/01/17 21:47:20.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import * as fn from "@denops/std/function";
import { selections } from "../pluginstatus.ts";
import { execCommand } from "../util.ts";

export const clap: Plug[] = [
  {
    url: "https://github.com/liuchengxu/vim-clap",
    enabled: selections.ff === "clap",
    profiles: ["ff"],
    build: async ({ denops, info }) => {
      if ((info.isInstalled || info.isUpdated) && info.isLoaded) {
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
