// =============================================================================
// File        : test.ts
// Author      : yukimemi
// Last Change : 2025/11/30 23:32:14.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus } from "../pluginstatus.ts";

import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";

export const test: Plug[] = [
  { url: "https://github.com/skywind3000/asyncrun.vim", profiles: ["test"] },
  {
    url: "https://github.com/vim-test/vim-test",
    enabled: pluginStatus.vimtest,
    profiles: ["test"],
    dependencies: [
      "https://github.com/skywind3000/asyncrun.vim",
    ],
    before: async ({ denops }) => {
      await vars.g.set(denops, "test#strategy", "neovim");
      await vars.g.set(denops, "test#javascript#denotest#options", {
        all: "--no-check --unstable-kv -A",
      });
    },
    after: async ({ denops }) => {
      await mapping.map(denops, "<space>Tn", "<cmd>TestNearest<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>Tf", "<cmd>TestFile<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>Ts", "<cmd>TestSuite<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>Tl", "<cmd>TestLast<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>Tg", "<cmd>TestVisit<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/nvim-neotest/nvim-nio",
    enabled: pluginStatus.neotest,
    profiles: ["test"],
  },
  {
    url: "https://github.com/antoinemadec/FixCursorHold.nvim",
    enabled: pluginStatus.neotest,
    profiles: ["test"],
  },
  {
    url: "https://github.com/nvim-neotest/neotest",
    enabled: pluginStatus.neotest,
    profiles: ["test"],
    dependencies: [
      "https://github.com/nvim-neotest/nvim-nio",
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/antoinemadec/FixCursorHold.nvim",
      "https://github.com/nvim-treesitter/nvim-treesitter",
    ],
    afterFile: "~/.config/nvim/rc/after/neotest.lua",
  },
];
