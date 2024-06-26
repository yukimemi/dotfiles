// =============================================================================
// File        : terminal.ts
// Author      : yukimemi
// Last Change : 2024/03/17 14:15:46.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.14.7/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v6.5.0/mapping/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const terminal: Plug[] = [
  {
    url: "https://github.com/voldikss/vim-floaterm",
    enabled: !pluginStatus.vscode,
    before: async ({ denops }) => {
      await mapping.map(denops, `<leader>t`, `<cmd>FloatermToggle<cr>`, {
        mode: "n",
      });
    },
  },
];
