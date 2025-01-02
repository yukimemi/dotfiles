// =============================================================================
// File        : terminal.ts
// Author      : yukimemi
// Last Change : 2025/01/02 18:00:41.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.0.2";

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
    enabled: true,
    cache: { afterFile: `~/.config/nvim/rc/after/toggleterm.lua` },
  },
];
