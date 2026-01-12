// =============================================================================
// File        : test.ts
// Author      : yukimemi
// Last Change : 2026/01/12 00:00:00.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus } from "../pluginstatus.ts";

import * as vars from "@denops/std/variable";

export const test: Plug[] = [
  {
    url: "https://github.com/skywind3000/asyncrun.vim",
    profiles: ["test"],
    lazy: { cmd: "AsyncRun" },
  },
  {
    url: "https://github.com/vim-test/vim-test",
    enabled: pluginStatus.vimtest,
    profiles: ["test"],
    lazy: {
      keys: [
        {
          lhs: "<space>Tn",
          rhs: "<cmd>TestNearest<cr>",
          mode: "n",
          desc: "Test nearest",
        },
        {
          lhs: "<space>Tf",
          rhs: "<cmd>TestFile<cr>",
          mode: "n",
          desc: "Test file",
        },
        {
          lhs: "<space>Ts",
          rhs: "<cmd>TestSuite<cr>",
          mode: "n",
          desc: "Test suite",
        },
        {
          lhs: "<space>Tl",
          rhs: "<cmd>TestLast<cr>",
          mode: "n",
          desc: "Test last",
        },
        {
          lhs: "<space>Tg",
          rhs: "<cmd>TestVisit<cr>",
          mode: "n",
          desc: "Test visit",
        },
      ],
      cmd: [
        "TestNearest",
        "TestFile",
        "TestSuite",
        "TestLast",
        "TestVisit",
      ],
    },
    dependencies: [
      "https://github.com/skywind3000/asyncrun.vim",
    ],
    before: async ({ denops }) => {
      await vars.g.set(denops, "test#strategy", "neovim");
      await vars.g.set(denops, "test#javascript#denotest#options", {
        all: "--no-check --unstable-kv -A",
      });
    },
  },
  {
    url: "https://github.com/nvim-neotest/nvim-nio",
    enabled: pluginStatus.neotest,
    profiles: ["test"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/antoinemadec/FixCursorHold.nvim",
    enabled: pluginStatus.neotest,
    profiles: ["test"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/nvim-neotest/neotest",
    enabled: pluginStatus.neotest,
    profiles: ["test"],
    lazy: {
      cmd: "Neotest",
    },
    dependencies: [
      "https://github.com/nvim-neotest/nvim-nio",
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/antoinemadec/FixCursorHold.nvim",
      "https://github.com/nvim-treesitter/nvim-treesitter",
    ],
    afterFile: "~/.config/nvim/rc/after/neotest.lua",
  },
];
