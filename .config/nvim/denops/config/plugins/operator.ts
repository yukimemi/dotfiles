// =============================================================================
// File        : operator.ts
// Author      : yukimemi
// Last Change : 2023/08/26 23:45:37.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";

import * as mapping from "jsr:@denops/std@7.0.0/mapping";

export const operator: Plug[] = [
  {
    url: "https://github.com/osyo-manga/vim-operator-stay-cursor",
    dependencies: [{ url: "https://github.com/kana/vim-operator-user" }],
  },
  {
    url: "https://github.com/machakann/vim-sandwich",
    dependencies: [{ url: "https://github.com/kana/vim-operator-user" }],
  },
  {
    url: "https://github.com/tyru/operator-html-escape.vim",
    dependencies: [{ url: "https://github.com/kana/vim-operator-user" }],
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
    url: "https://github.com/yuki-yano/vim-operator-replace",
    dependencies: [{ url: "https://github.com/kana/vim-operator-user" }],
    before: async ({ denops }) => {
      await mapping.map(denops, "_", "<Plug>(operator-replace)", {
        mode: ["n", "x"],
      });
    },
  },
];
