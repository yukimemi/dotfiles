import * as mapping from "https://deno.land/x/denops_std@v4.3.1/mapping/mod.ts";
import { Denops } from "https://deno.land/x/denops_std@v4.3.1/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@0.0.5/plugin.ts";

export const edit: Plug[] = [
  { url: "Shougo/context_filetype.vim" },
  {
    url: "uga-rosa/contextment.vim",
    before: async (denops: Denops) => {
      await mapping.map(denops, "gcc", "<Plug>(contextment)", { mode: "x" });
      await mapping.map(denops, "gcc", "<Plug>(contextment-line)", {
        mode: "n",
      });
    },
  },
];
