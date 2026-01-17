// =============================================================================
// File        : runner.ts
// Author      : yukimemi
// Last Change : 2026/01/17 22:48:48.
// =============================================================================

import * as vars from "@denops/std/variable";
import type { Plug } from "@yukimemi/dvpm";
import { selections } from "../pluginstatus.ts";

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
    enabled: selections.runner === "quickrun",
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
    before: async ({ denops }) => {
      await vars.g.set(denops, "quickrun_config", {
        _: {
          runner: "nvimterm",
        },
      });
    },
  },
  {
    url: "https://github.com/stevearc/overseer.nvim",
    enabled: selections.runner === "overseer",
    profiles: ["runner"],
    lazy: {
      keys: [
        { lhs: "<space>Oo", rhs: "<cmd>OverseerToggle<cr>", mode: ["n", "x"] },
        { lhs: "<space>Or", rhs: "<cmd>OverseerRun<cr>", mode: ["n"] },
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
    enabled: selections.runner === "zignite",
    profiles: ["runner"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("zignite").setup(_A)`, {});
    },
  },
];
