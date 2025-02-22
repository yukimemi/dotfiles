// =============================================================================
// File        : textobj.ts
// Author      : yukimemi
// Last Change : 2025/02/01 16:47:36.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.2";
import * as mapping from "jsr:@denops/std@7.5.0/mapping";

export const textobj: Plug[] = [
  {
    url: "https://github.com/kana/vim-textobj-user",
    profiles: ["default"],
  },
  {
    url: "https://github.com/kana/vim-textobj-entire",
    profiles: ["default"],
    dependencies: ["https://github.com/kana/vim-textobj-user"],
  },
  {
    url: "https://github.com/kana/vim-textobj-indent",
    profiles: ["default"],
    dependencies: ["https://github.com/kana/vim-textobj-user"],
  },
  {
    url: "https://github.com/kana/vim-textobj-line",
    profiles: ["default"],
    dependencies: ["https://github.com/kana/vim-textobj-user"],
  },
  {
    url: "https://github.com/gilligan/textobj-lastpaste",
    dependencies: ["https://github.com/kana/vim-textobj-user"],
  },
  {
    url: "https://github.com/machakann/vim-swap",
    profiles: ["default"],
  },
  { url: "https://github.com/machakann/vim-textobj-functioncall" },
  {
    url: "https://github.com/yuki-yano/vim-textobj-generics",
    dependencies: ["https://github.com/machakann/vim-textobj-functioncall"],
  },
  {
    url: "https://github.com/terryma/vim-expand-region",
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
