// =============================================================================
// File        : terminal.ts
// Author      : yukimemi
// Last Change : 2024/03/17 14:15:46.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.6";

import * as mapping from "jsr:@denops/std@7.2.0/mapping";
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
