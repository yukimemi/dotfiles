// =============================================================================
// File        : test.ts
// Author      : yukimemi
// Last Change : 2024/09/29 19:27:24.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.7";

import * as mapping from "jsr:@denops/std@7.2.0/mapping";
import * as vars from "jsr:@denops/std@7.2.0/variable";
import { pluginStatus } from "../pluginstatus.ts";

export const test: Plug[] = [
  { url: "https://github.com/skywind3000/asyncrun.vim" },
  {
    url: "https://github.com/vim-test/vim-test",
    enabled: !pluginStatus.vscode,
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
];
