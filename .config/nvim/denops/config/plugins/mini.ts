// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2024/09/29 01:18:20.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.9";

import * as mapping from "jsr:@denops/std@7.2.0/mapping";

export const mini: Plug[] = [
  {
    url: "https://github.com/echasnovski/mini.nvim",
    after: async ({ denops }) => {
      // animate.
      if (denops.meta.platform !== "windows") {
        await denops.call(`luaeval`, `require("mini.animate").setup()`);
      }

      // files.
      await denops.call(`luaeval`, `require("mini.files").setup()`);
      await mapping.map(denops, "mF", "<cmd>lua require('mini.files').open()<cr>", { mode: "n" });

      // splitjoin.
      await denops.call(`luaeval`, `require("mini.splitjoin").setup()`);

      // pick.
      await denops.call(`luaeval`, `require('mini.pick').setup()`);
    },
    afterFile: `~/.config/nvim/rc/after/mini.lua`,
  },
];
