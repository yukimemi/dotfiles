import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";

export const test: Plug[] = [
  {
    url: "vim-test/vim-test",
    before: async ({ denops }) => {
      await vars.g.set(denops, "test#javascript#denotest#options", {
        all: "--no-check --unstable -A",
      });
    },
    after: async ({ denops }) => {
      await mapping.map(denops, "<space>tn", "<cmd>TestNearest<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>tf", "<cmd>TestFile<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>ts", "<cmd>TestSuite<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>tl", "<cmd>TestLast<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>tg", "<cmd>TestVisit<cr>", {
        mode: "n",
      });
    },
  },
];
