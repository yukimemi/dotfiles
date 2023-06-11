import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";

export const terminal: Plug[] = [
  {
    url: "voldikss/vim-floaterm",
    before: async ({ denops }) => {
      await mapping.map(denops, `<leader>t`, `<cmd>FloatermToggle<cr>`, {
        mode: "n",
      });
      await mapping.map(denops, `<leader>t`, `<C-\><C-n>:FloatermToggle<cr>`, {
        mode: "t",
      });
    },
  },
];
