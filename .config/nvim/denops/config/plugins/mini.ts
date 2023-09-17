// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2023/09/17 13:40:38.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.3.3/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";

export const mini: Plug[] = [
  {
    url: "echasnovski/mini.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      // animate.
      if (denops.meta.platform !== "windows") {
        await denops.call(`luaeval`, `require("mini.animate").setup()`);
      }

      // files.
      await denops.call(`luaeval`, `require("mini.files").setup()`);
      await mapping.map(denops, "mf", "<cmd>lua require('mini.files').open()<cr>", { mode: "n" });

      // splitjoin.
      await denops.call(`luaeval`, `require("mini.splitjoin").setup()`);
    },
  },
];
