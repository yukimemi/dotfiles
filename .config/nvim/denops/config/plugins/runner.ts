// =============================================================================
// File        : runner.ts
// Author      : yukimemi
// Last Change : 2024/10/19 13:10:22.
// =============================================================================

import * as mapping from "jsr:@denops/std@7.3.2/mapping";
import * as vars from "jsr:@denops/std@7.3.2/variable";
import type { Plug } from "jsr:@yukimemi/dvpm@5.0.14";
import { pluginStatus } from "../pluginstatus.ts";

export const runner: Plug[] = [
  { url: "https://github.com/lambdalisue/vim-quickrun-neovim-job" },
  { url: "https://github.com/statiolake/vim-quickrun-runner-nvimterm" },
  {
    url: "https://github.com/thinca/vim-quickrun",
    enabled: pluginStatus.quickrun,
    dependencies: [
      "https://github.com/lambdalisue/vim-quickrun-neovim-job",
      "https://github.com/statiolake/vim-quickrun-runner-nvimterm",
    ],
    after: async ({ denops }) => {
      await vars.g.set(denops, "quickrun_config", {
        _: {
          runner: "nvimterm",
        },
      });
      await mapping.map(denops, "<space>qr", "<Plug>(quickrun)", { mode: ["n", "x", "v"] });
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
