// =============================================================================
// File        : clap.ts
// Author      : yukimemi
// Last Change : 2024/03/23 15:49:05.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.3/mod.ts";

import { pluginStatus } from "../pluginstatus.ts";

export const clap: Plug[] = [
  {
    url: "https://github.com/liuchengxu/vim-clap",
    enabled: pluginStatus.clap && !pluginStatus.vscode,
    afterFile: "~/.config/nvim/rc/after/vim-clap.vim",
    build: async ({ denops }) => {
      await denops.cmd(`Clap install-binary!`);
    },
  },
];
