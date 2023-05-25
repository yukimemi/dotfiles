import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.5/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";

export const terminal: Plug[] = [
  {
    url: "voldikss/vim-floaterm",
    before: async (denops: Denops) => {
      await mapping.map(denops, `<c-s>`, `<cmd>FloatermToggle<cr>`, {
        mode: "n",
      });
      await mapping.map(denops, `<c-s>`, `<C-\><C-n>:FloatermToggle<cr>`, {
        mode: "t",
      });
    },
  },
];
