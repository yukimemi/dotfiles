// =============================================================================
// File        : operator.ts
// Author      : yukimemi
// Last Change : 2025/01/02 11:05:06.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.0.0";

import * as mapping from "jsr:@denops/std@7.4.0/mapping";

export const operator: Plug[] = [
  {
    url: "https://github.com/kana/vim-operator-user",
    profiles: ["default"],
  },
  {
    url: "https://github.com/osyo-manga/vim-operator-stay-cursor",
    enabled: false,
    dependencies: ["https://github.com/kana/vim-operator-user"],
    after: async ({ denops }) => {
      await mapping.map(denops, "y", "<Plug>(operator-stay-cursor-yank)", {
        mode: ["n", "x", "v"],
      });
    },
  },
  {
    url: "https://github.com/machakann/vim-sandwich",
    profiles: ["default"],
    dependencies: ["https://github.com/kana/vim-operator-user"],
  },
  {
    url: "https://github.com/tyru/operator-html-escape.vim",
    enabled: false,
    dependencies: ["https://github.com/kana/vim-operator-user"],
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
    url: "https://github.com/kana/vim-operator-replace",
    profiles: ["default"],
    dependencies: ["https://github.com/kana/vim-operator-user"],
    before: async ({ denops }) => {
      await mapping.map(denops, "_", "<Plug>(operator-replace)", {
        mode: ["n", "x"],
      });
    },
  },
];
