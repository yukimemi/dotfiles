// =============================================================================
// File        : textobj.ts
// Author      : yukimemi
// Last Change : 2026/01/06 00:00:00.
// =============================================================================

import * as mapping from "@denops/std/mapping";
import type { Plug } from "@yukimemi/dvpm";

export const textobj: Plug[] = [
  {
    url: "https://github.com/kana/vim-textobj-user",
    profiles: ["textobj"],
  },
  {
    url: "https://github.com/kana/vim-textobj-entire",
    profiles: ["textobj"],
    dependencies: ["https://github.com/kana/vim-textobj-user"],
  },
  {
    url: "https://github.com/kana/vim-textobj-indent",
    profiles: ["textobj"],
    dependencies: ["https://github.com/kana/vim-textobj-user"],
  },
  {
    url: "https://github.com/kana/vim-textobj-line",
    profiles: ["textobj"],
    dependencies: ["https://github.com/kana/vim-textobj-user"],
  },
  {
    url: "https://github.com/gilligan/textobj-lastpaste",
    profiles: ["textobj"],
    dependencies: ["https://github.com/kana/vim-textobj-user"],
  },
  {
    url: "https://github.com/machakann/vim-swap",
    profiles: ["textobj"],
    lazy: {
      keys: [
        { lhs: "g<", mode: ["n", "x"] },
        { lhs: "g>", mode: ["n", "x"] },
        { lhs: "gs", mode: ["n", "x"] },
      ],
    },
  },
  {
    url: "https://github.com/machakann/vim-textobj-functioncall",
    profiles: ["textobj"],
  },
  {
    url: "https://github.com/yuki-yano/vim-textobj-generics",
    profiles: ["textobj"],
    dependencies: ["https://github.com/machakann/vim-textobj-functioncall"],
  },
  {
    url: "https://github.com/terryma/vim-expand-region",
    profiles: ["textobj"],
    lazy: {
      keys: [
        { lhs: "+", mode: "x" },
        { lhs: "-", mode: "x" },
      ],
    },
    before: async ({ denops }) => {
      await mapping.map(denops, "+", `<Plug>(expand_region_expand)`, {
        mode: "x",
        silent: true,
      });
      await mapping.map(denops, "-", `<Plug>(expand_region_shrink)`, {
        mode: "x",
        silent: true,
      });
    },
  },
];
