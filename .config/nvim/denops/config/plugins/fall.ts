// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2024/03/10 18:03:55.
// =============================================================================

import * as mapping from "https://deno.land/x/denops_std@v6.3.0/mapping/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@3.8.1/mod.ts";

export const fall: Plug[] = [
  {
    url: "https://github.com/vim-fall/fall.vim",
    after: async ({ denops }) => {
      await mapping.map(denops, `<leader>lf`, `<cmd>Fall file<cr>`, { mode: "n" });
    },
  },
];
