// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2023/09/05 09:58:51.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.3.2/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";

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

      // indentscope.
      await denops.call(`luaeval`, `require("mini.indentscope").setup()`);
      autocmd.group(denops, "MyMiniIndentscope", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          ["fern"],
          `let b:miniindentscope_disable = v:true`,
        );
      });

      // splitjoin.
      await denops.call(`luaeval`, `require("mini.splitjoin").setup()`);
    },
  },
];
