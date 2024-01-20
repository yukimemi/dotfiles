// =============================================================================
// File        : run.ts
// Author      : yukimemi
// Last Change : 2024/01/20 22:22:33.
// =============================================================================

import * as vars from "https://deno.land/x/denops_std@v5.2.0/variable/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@3.8.1/mod.ts";

export const run: Plug[] = [
  {
    url: "https://github.com/thinca/vim-quickrun",
    dependencies: [
      { url: "https://github.com/lambdalisue/vim-quickrun-neovim-job" },
      { url: "https://github.com/statiolake/vim-quickrun-runner-nvimterm" }
    ],
    after: async ({ denops }) => {
      await vars.g.set(denops, "quickrun_config", {
        _: {
          runner: "nvimterm",
        },
      });
    },
  },
];
