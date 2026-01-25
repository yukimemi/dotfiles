// =============================================================================
// File        : operator.ts
// Author      : yukimemi
// Last Change : 2026/01/06 00:00:00.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

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
      keys: [
        {
          lhs: "y",
          rhs: "<Plug>(operator-stay-cursor-yank)",
          mode: ["n", "x"],
        },
      ],
    },
    dependencies: ["https://github.com/kana/vim-operator-user"],
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
        { lhs: "<c-h>", rhs: "<Plug>(operator-html-escape)", mode: "x" },
        { lhs: "<c-u>", rhs: "<Plug>(operator-html-unescape)", mode: "x" },
      ],
    },
    dependencies: ["https://github.com/kana/vim-operator-user"],
  },
  {
    url: "https://github.com/kana/vim-operator-replace",
    profiles: ["operator"],
    lazy: {
      keys: [{ lhs: "_", rhs: "<Plug>(operator-replace)", mode: ["n", "x"] }],
    },
    dependencies: ["https://github.com/kana/vim-operator-user"],
  },
];
