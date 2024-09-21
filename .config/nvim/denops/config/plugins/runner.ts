// =============================================================================
// File        : runner.ts
// Author      : yukimemi
// Last Change : 2024/09/21 16:49:37.
// =============================================================================

import * as mapping from "jsr:@denops/std@7.1.1/mapping";
import * as vars from "jsr:@denops/std@7.1.1/variable";
import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";
import { pluginStatus } from "../pluginstatus.ts";

export const runner: Plug[] = [
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
      await mapping.map(denops, "<space>r", "<Plug>(quickrun)");
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
