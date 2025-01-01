// =============================================================================
// File        : terminal.ts
// Author      : yukimemi
// Last Change : 2025/01/01 20:29:23.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.5.2";

import * as mapping from "jsr:@denops/std@7.4.0/mapping";

export const terminal: Plug[] = [
  {
    url: "https://github.com/voldikss/vim-floaterm",
    enabled: false,
    after: async ({ denops }) => {
      await mapping.map(denops, `<c-s>`, `<cmd>FloatermToggle<cr>`, {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/akinsho/toggleterm.nvim",
    enabled: true,
    afterFile: `~/.config/nvim/rc/after/toggleterm.lua`,
  },
];
