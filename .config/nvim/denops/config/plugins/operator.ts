import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v4.3.3/mapping/mod.ts";

export const operator: Plug[] = [
  {
    url: "machakann/vim-sandwich",
    dependencies: [{ url: "kana/vim-operator-user" }],
  },
  {
    url: "tyru/operator-html-escape.vim",
    dependencies: [{ url: "kana/vim-operator-user" }],
  },
  {
    url: "yuki-yano/vim-operator-replace",
    dependencies: [{ url: "kana/vim-operator-user" }],
    before: async (denops: Denops) => {
      await mapping.map(denops, "_", "<Plug>(operator-replace)", {
        mode: ["n", "x"],
      });
    },
  },
];
