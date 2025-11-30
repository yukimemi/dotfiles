// =============================================================================
// File        : runner.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:12:39.
// =============================================================================

import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";
import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus } from "../pluginstatus.ts";

export const runner: Plug[] = [
  {
    url: "https://github.com/lambdalisue/vim-quickrun-neovim-job",
    profiles: ["runner"],
  },
  {
    url: "https://github.com/statiolake/vim-quickrun-runner-nvimterm",
    profiles: ["runner"],
  },
  {
    url: "https://github.com/thinca/vim-quickrun",
    enabled: pluginStatus.quickrun,
    profiles: ["runner"],
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
      await mapping.map(denops, "<space>qr", "<Plug>(quickrun)", {
        mode: ["n", "x", "v"],
      });
    },
  },
  {
    url: "https://github.com/stevearc/overseer.nvim",
    enabled: pluginStatus.overseer,
    profiles: ["runner"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("overseer").setup()`);
      await mapping.map(denops, "<space>t", "<cmd>OverseerToggle<cr>", {
        mode: ["n", "x", "v"],
      });
      await mapping.map(denops, "<space>r", "<cmd>OverseerRun<cr>", {
        mode: "n",
      });
    },
  },
];
