import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.6/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";

export const search: Plug[] = [
  {
    url: "haya14busa/vim-asterisk",
    after: async (denops: Denops) => {
      await mapping.map(denops, "*", "<Plug>(asterisk-z*)zv", {
        mode: ["n", "o", "x"],
      });
      await mapping.map(denops, "g*", "<Plug>(asterisk-gz*)zv", {
        mode: ["n", "o", "x"],
      });
      await mapping.map(denops, "#", "<Plug>(asterisk-z#)zv", {
        mode: ["n", "o", "x"],
      });
      await mapping.map(denops, "g#", "<Plug>(asterisk-gz#)zv", {
        mode: ["n", "o", "x"],
      });
    },
  },
];
