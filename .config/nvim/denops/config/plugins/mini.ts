// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2024/03/17 14:16:00.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.3/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v6.4.0/mapping/mod.ts";

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
  },
];
