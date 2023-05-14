import * as mapping from "https://deno.land/x/denops_std@v4.3.1/mapping/mod.ts";
import { Denops } from "https://deno.land/x/denops_std@v4.3.1/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@0.0.3/plugin.ts";

export const operator: Plug[] = [
  { url: "kana/vim-operator-user" },
  { url: "machakann/vim-sandwich" },
  { url: "tyru/operator-html-escape.vim" },
  {
    url: "yuki-yano/vim-operator-replace",
    before: async (denops: Denops) => {
      await mapping.map(denops, "_", "<Plug>(operator-replace)", {
        mode: ["n", "x"],
      });
    },
  },
];
