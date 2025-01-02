// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2024/11/04 22:27:06.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.0.2";

export const mini: Plug[] = [
  {
    url: "https://github.com/echasnovski/mini.nvim",
    after: async ({ denops }) => {
      // animate.
      if (denops.meta.platform !== "windows") {
        await denops.call(`luaeval`, `require("mini.animate").setup()`);
      }

      // splitjoin.
      await denops.call(`luaeval`, `require("mini.splitjoin").setup()`);
    },
    afterFile: `~/.config/nvim/rc/after/mini.lua`,
  },
];
