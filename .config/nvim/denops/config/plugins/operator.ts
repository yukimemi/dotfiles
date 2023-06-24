import type { Plug } from "https://deno.land/x/dvpm@1.3.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";

export const operator: Plug[] = [
  {
    url: "osyo-manga/vim-operator-stay-cursor",
    dependencies: [{ url: "kana/vim-operator-user" }],
  },
  {
    url: "machakann/vim-sandwich",
    dependencies: [{ url: "kana/vim-operator-user" }],
  },
  {
    url: "tyru/operator-html-escape.vim",
    dependencies: [{ url: "kana/vim-operator-user" }],
    before: async ({ denops }) => {
      await mapping.map(denops, "<c-h>", "<Plug>(operator-html-escape)", {
        mode: "x",
      });
      await mapping.map(denops, "<c-u>", "<Plug>(operator-html-unescape)", {
        mode: "x",
      });
    },
  },
  {
    url: "yuki-yano/vim-operator-replace",
    dependencies: [{ url: "kana/vim-operator-user" }],
    before: async ({ denops }) => {
      await mapping.map(denops, "_", "<Plug>(operator-replace)", {
        mode: ["n", "x"],
      });
    },
  },
];
