// =============================================================================
// File        : terminal.ts
// Author      : yukimemi
// Last Change : 2025/01/26 18:24:29.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.0";

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
    profiles: ["default"],
    enabled: false,
    cache: { afterFile: `~/.config/nvim/rc/after/toggleterm.lua` },
  },
];
