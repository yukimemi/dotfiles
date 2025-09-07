// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2025/05/10 20:53:07.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";

export const mini: Plug[] = [
  {
    url: "https://github.com/echasnovski/mini.nvim",
    profiles: ["mini"],
    after: async ({ denops }) => {
      // animate.
      if (denops.meta.platform !== "windows") {
        await denops.call(`luaeval`, `require("mini.animate").setup()`);
      }

      // splitjoin.
      await denops.call(`luaeval`, `require("mini.splitjoin").setup()`);

      // trailspace.
      await denops.call(`luaeval`, `require("mini.trailspace").setup()`);
    },
    afterFile: `~/.config/nvim/rc/after/mini.lua`,
  },
];
