// =============================================================================
// File        : runner.ts
// Author      : yukimemi
// Last Change : 2025/01/03 10:39:46.
// =============================================================================

import * as mapping from "jsr:@denops/std@7.4.0/mapping";
import * as vars from "jsr:@denops/std@7.4.0/variable";
import type { Plug } from "jsr:@yukimemi/dvpm@6.1.0";
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
    profiles: ["full"],
    enabled: pluginStatus.overseer,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("overseer").setup()`);
      await mapping.map(denops, "<space>t", "<cmd>OverseerToggle<cr>", { mode: ["n", "x", "v"] });
      await mapping.map(denops, "<space>r", "<cmd>OverseerRun<cr>", { mode: "n" });
    },
  },
];
