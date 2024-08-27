// =============================================================================
// File        : run.ts
// Author      : yukimemi
// Last Change : 2024/07/27 22:27:25.
// =============================================================================

import * as vars from "jsr:@denops/std@7.1.0/variable";
import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";
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
