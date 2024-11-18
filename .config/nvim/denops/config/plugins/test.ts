// =============================================================================
// File        : test.ts
// Author      : yukimemi
// Last Change : 2024/11/18 17:44:38.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.1.7";
import { pluginStatus } from "../pluginstatus.ts";

import * as mapping from "jsr:@denops/std@7.3.2/mapping";
import * as vars from "jsr:@denops/std@7.3.2/variable";

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
  { url: "https://github.com/nvim-lua/plenary.nvim" },
  { url: "https://github.com/antoinemadec/FixCursorHold.nvim" },
  { url: "https://github.com/nvim-treesitter/nvim-treesitter" },
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
