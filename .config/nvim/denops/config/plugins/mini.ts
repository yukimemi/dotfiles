// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2025/01/26 11:39:07.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.0.1";

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
