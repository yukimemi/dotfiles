// =============================================================================
// File        : test.ts
// Author      : yukimemi
// Last Change : 2025/01/26 11:38:39.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";
import { pluginStatus } from "../pluginstatus.ts";

import * as mapping from "jsr:@denops/std@8.0.0/mapping";
import * as vars from "jsr:@denops/std@8.0.0/variable";

export const test: Plug[] = [
  { url: "https://github.com/skywind3000/asyncrun.vim" },
  {
    url: "https://github.com/vim-test/vim-test",
    enabled: pluginStatus.vimtest,
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
  { url: "https://github.com/nvim-neotest/nvim-nio" },
  { url: "https://github.com/antoinemadec/FixCursorHold.nvim" },
  {
    url: "https://github.com/nvim-neotest/neotest",
    enabled: pluginStatus.neotest,
    dependencies: [
      "https://github.com/nvim-neotest/nvim-nio",
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/antoinemadec/FixCursorHold.nvim",
      "https://github.com/nvim-treesitter/nvim-treesitter",
    ],
    afterFile: "~/.config/nvim/rc/after/neotest.lua",
  },
];
