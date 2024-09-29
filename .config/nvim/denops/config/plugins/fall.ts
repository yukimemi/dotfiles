// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2024/06/03 23:33:50.
// =============================================================================

import * as mapping from "jsr:@denops/std@7.2.0/mapping";
import type { Plug } from "jsr:@yukimemi/dvpm@5.0.6";
import { pluginStatus } from "../pluginstatus.ts";

export const fall: Plug[] = [
  { url: "https://github.com/lambdalisue/vim-fall-source-mr", enabled: false },
  {
    url: "https://github.com/lambdalisue/vim-fall",
    enabled: pluginStatus.fall,
    dependencies: [
      "https://github.com/lambdalisue/vim-fall-source-mr",
    ],
    after: async ({ denops }) => {
      await mapping.map(denops, `<leader>lf`, `<cmd>Fall file<cr>`, { mode: "n" });
    },
  },
];
