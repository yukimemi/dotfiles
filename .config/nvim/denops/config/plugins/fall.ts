// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2024/05/11 16:26:34.
// =============================================================================

import * as mapping from "https://deno.land/x/denops_std@v6.4.2/mapping/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@3.11.0/mod.ts";

export const fall: Plug[] = [
  {
    url: "https://github.com/vim-fall/vim-fall",
    dependencies: [
      { url: "https://github.com/lambdalisue/vim-fall-source-mr" },
    ],
    after: async ({ denops }) => {
      await mapping.map(denops, `<leader>lf`, `<cmd>Fall file<cr>`, { mode: "n" });
    },
  },
];
