// =============================================================================
// File        : operator.ts
// Author      : yukimemi
// Last Change : 2026/01/06 00:00:00.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as mapping from "@denops/std/mapping";

export const operator: Plug[] = [
  {
    url: "https://github.com/kana/vim-operator-user",
    profiles: ["operator"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/osyo-manga/vim-operator-stay-cursor",
    enabled: false,
    profiles: ["operator"],
    lazy: {
      keys: [{ lhs: "y", mode: ["n", "x"] }],
    },
    dependencies: ["https://github.com/kana/vim-operator-user"],
    after: async ({ denops }) => {
      await mapping.map(denops, "y", "<Plug>(operator-stay-cursor-yank)", {
        mode: ["n", "x", "v"],
      });
    },
  },
  {
    url: "https://github.com/machakann/vim-sandwich",
    profiles: ["operator"],
    lazy: {
      keys: [
        { lhs: "sa", mode: ["n", "x", "o"] },
        { lhs: "sd", mode: "n" },
        { lhs: "sr", mode: "n" },
      ],
    },
    dependencies: ["https://github.com/kana/vim-operator-user"],
  },
  {
    url: "https://github.com/tyru/operator-html-escape.vim",
    enabled: false,
    profiles: ["operator"],
    lazy: {
      keys: [
        { lhs: "<c-h>", mode: "x" },
        { lhs: "<c-u>", mode: "x" },
      ],
    },
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
    profiles: ["operator"],
    lazy: {
      keys: [{ lhs: "_", mode: ["n", "x"] }],
    },
    dependencies: ["https://github.com/kana/vim-operator-user"],
    before: async ({ denops }) => {
      await mapping.map(denops, "_", "<Plug>(operator-replace)", {
        mode: ["n", "x"],
      });
    },
  },
];
