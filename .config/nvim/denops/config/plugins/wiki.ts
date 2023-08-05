// =============================================================================
// File        : wiki.ts
// Author      : yukimemi
// Last Change : 2023/07/17 20:28:10.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.0.0/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";

import { pluginStatus } from "../main.ts";

export const wiki: Plug[] = [
  {
    url: "vimwiki/vimwiki",
    enabled: pluginStatus.vimwiki,
    before: async ({ denops }) => {
      await globals.set(denops, "vimwiki_list", [
        {
          path: "~/.vimwiki",
          syntax: "markdown",
          ext: ".md",
        },
      ]);
    },
  },
];
