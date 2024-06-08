// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2024/06/03 23:33:50.
// =============================================================================

import * as mapping from "https://deno.land/x/denops_std@v6.5.0/mapping/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@3.14.0/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const fall: Plug[] = [
  {
    url: "https://github.com/lambdalisue/vim-fall",
    enabled: pluginStatus.fall,
    dependencies: [
      { url: "https://github.com/lambdalisue/vim-fall-source-mr", enabled: false },
    ],
    after: async ({ denops }) => {
      await mapping.map(denops, `<leader>lf`, `<cmd>Fall file<cr>`, { mode: "n" });
    },
  },
];
