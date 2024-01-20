// =============================================================================
// File        : terminal.ts
// Author      : yukimemi
// Last Change : 2023/11/11 22:29:14.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.1/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.3.0/mapping/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const terminal: Plug[] = [
  {
    url: "https://github.com/voldikss/vim-floaterm",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    before: async ({ denops }) => {
      await mapping.map(denops, `<leader>t`, `<cmd>FloatermToggle<cr>`, {
        mode: "n",
      });
    },
  },
];
