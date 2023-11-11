// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2023/11/11 22:29:15.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.5.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";

export const mini: Plug[] = [
  {
    url: "https://github.com/echasnovski/mini.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      // animate.
      if (denops.meta.platform !== "windows") {
        await denops.call(`luaeval`, `require("mini.animate").setup()`);
      }

      // indentscope.
      if (denops.meta.platform !== "windows") {
        await denops.call(`luaeval`, `require("mini.indentscope").setup()`);
        autocmd.group(denops, "MyMiniIndentscope", (helper) => {
          helper.remove("*");
          helper.define(
            "FileType",
            ["fern"],
            `let b:miniindentscope_disable = v:true`,
          );
        });
      }

      // files.
      await denops.call(`luaeval`, `require("mini.files").setup()`);
      await mapping.map(denops, "mf", "<cmd>lua require('mini.files').open()<cr>", { mode: "n" });

      // splitjoin.
      await denops.call(`luaeval`, `require("mini.splitjoin").setup()`);

      // pick.
      await denops.call(`luaeval`, `require('mini.pick').setup()`);
    },
  },
];
