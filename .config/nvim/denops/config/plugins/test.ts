// =============================================================================
// File        : test.ts
// Author      : yukimemi
// Last Change : 2023/10/08 12:12:03.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.6.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.2.0/mapping/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.2.0/variable/mod.ts";
import { pluginStatus } from "../main.ts";

export const test: Plug[] = [
  {
    url: "https://github.com/vim-test/vim-test",
    enabled: !pluginStatus.vscode,
    dependencies: [
      { url: "https://github.com/skywind3000/asyncrun.vim" },
    ],
    before: async ({ denops }) => {
      await vars.g.set(denops, "test#strategy", "floaterm");
      await vars.g.set(denops, "test#javascript#denotest#options", {
        all: "--no-check --unstable -A",
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
