// =============================================================================
// File        : terminal.ts
// Author      : yukimemi
// Last Change : 2025/01/01 20:34:12.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.6.0";

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
    cache: { afterFile: `~/.config/nvim/rc/after/toggleterm.lua` },
  },
];
