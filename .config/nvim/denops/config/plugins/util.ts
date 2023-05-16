import { globals } from "https://deno.land/x/denops_std@v4.3.1/variable/mod.ts";
import { Denops } from "https://deno.land/x/denops_std@v4.3.1/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@0.1.0/mod.ts";

export const util: Plug[] = [
  {
    url: "thinca/vim-partedit",
    before: async (denops: Denops) => {
      await globals.set(denops, "partedit#opener", "vsplit");
    },
  },
  { url: "tyru/capture.vim" },
];
