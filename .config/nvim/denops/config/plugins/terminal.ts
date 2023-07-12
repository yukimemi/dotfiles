import type { Plug } from "https://deno.land/x/dvpm@2.3.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { pluginStatus } from "../main.ts";

export const terminal: Plug[] = [
  {
    url: "voldikss/vim-floaterm",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && !pluginStatus.vscode,
    before: async ({ denops }) => {
      await mapping.map(denops, `<leader>t`, `<cmd>FloatermToggle<cr>`, {
        mode: "n",
      });
    },
  },
];
