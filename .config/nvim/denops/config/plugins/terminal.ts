// =============================================================================
// File        : terminal.ts
// Author      : yukimemi
// Last Change : 2024/10/01 23:58:30.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.12";

import * as mapping from "jsr:@denops/std@7.3.0/mapping";

export const terminal: Plug[] = [
  {
    url: "https://github.com/voldikss/vim-floaterm",
    before: async ({ denops }) => {
      await mapping.map(denops, `<leader>t`, `<cmd>FloatermToggle<cr>`, {
        mode: "n",
      });
    },
  },
];
