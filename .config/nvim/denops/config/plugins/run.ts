// =============================================================================
// File        : run.ts
// Author      : yukimemi
// Last Change : 2024/05/06 16:57:33.
// =============================================================================

import * as vars from "https://deno.land/x/denops_std@v6.4.2/variable/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@3.11.0/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const run: Plug[] = [
  {
    url: "https://github.com/thinca/vim-quickrun",
    enabled: pluginStatus.quickrun,
    dependencies: [
      { url: "https://github.com/lambdalisue/vim-quickrun-neovim-job" },
      { url: "https://github.com/statiolake/vim-quickrun-runner-nvimterm" },
    ],
    after: async ({ denops }) => {
      await vars.g.set(denops, "quickrun_config", {
        _: {
          runner: "nvimterm",
        },
      });
    },
  },
  {
    url: "https://github.com/stevearc/overseer.nvim",
    enabled: pluginStatus.overseer,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("overseer").setup()`);
    },
  },
];
