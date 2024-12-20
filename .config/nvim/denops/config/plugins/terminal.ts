// =============================================================================
// File        : terminal.ts
// Author      : yukimemi
// Last Change : 2024/11/10 20:50:38.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.5.2";

import * as mapping from "jsr:@denops/std@7.4.0/mapping";

export const terminal: Plug[] = [
  {
    url: "https://github.com/voldikss/vim-floaterm",
    after: async ({ denops }) => {
      await mapping.map(denops, `<c-s>`, `<cmd>FloatermToggle<cr>`, {
        mode: "n",
      });
    },
  },
];
