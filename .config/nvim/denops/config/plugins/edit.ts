import * as mapping from "https://deno.land/x/denops_std@v4.3.1/mapping/mod.ts";
import { Denops } from "https://deno.land/x/denops_std@v4.3.1/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v4.3.1/helper/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@0.1.0/mod.ts";

export const edit: Plug[] = [
  {
    url: "windwp/nvim-autopairs",
    after: async (denops: Denops) => {
      await execute(denops, `lua require("nvim-autopairs").setup()`);
    },
  },
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
