// =============================================================================
// File        : runner.ts
// Author      : yukimemi
// Last Change : 2026/01/12 21:26:42.
// =============================================================================

import * as vars from "@denops/std/variable";
import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus } from "../pluginstatus.ts";

export const runner: Plug[] = [
  {
    url: "https://github.com/lambdalisue/vim-quickrun-neovim-job",
    profiles: ["runner"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/statiolake/vim-quickrun-runner-nvimterm",
    profiles: ["runner"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/thinca/vim-quickrun",
    enabled: pluginStatus.quickrun,
    profiles: ["runner"],
    dependencies: [
      "https://github.com/lambdalisue/vim-quickrun-neovim-job",
      "https://github.com/statiolake/vim-quickrun-runner-nvimterm",
    ],
    lazy: {
      cmd: "QuickRun",
      keys: [
        { lhs: "<space>qr", rhs: "<Plug>(quickrun)", mode: ["n", "x"] },
      ],
    },
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
    profiles: ["runner"],
    lazy: {
      keys: [
        { lhs: "<space>O", rhs: "<cmd>OverseerToggle<cr>", mode: ["n", "x"] },
      ],
      cmd: [
        "OverseerOpen",
        "OverseerClose",
        "OverseerToggle",
        "OverseerRun",
        "OverseerShell",
        "OverseerTaskAction",
      ],
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("overseer").setup()`);
    },
  },
  {
    url: "https://github.com/valonmulolli/zignite.nvim",
    enabled: pluginStatus.zignite,
    profiles: ["runner"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("zignite").setup(_A)`, {});
    },
  },
];
