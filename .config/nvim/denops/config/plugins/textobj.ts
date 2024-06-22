// =============================================================================
// File        : textobj.ts
// Author      : yukimemi
// Last Change : 2024/04/28 16:38:22.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.12.0/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v6.5.0/mapping/mod.ts";

export const textobj: Plug[] = [
  {
    url: "https://github.com/kana/vim-textobj-entire",
    dependencies: [{ url: "https://github.com/kana/vim-textobj-user" }],
  },
  {
    url: "https://github.com/kana/vim-textobj-indent",
    dependencies: [{ url: "https://github.com/kana/vim-textobj-user" }],
  },
  {
    url: "https://github.com/kana/vim-textobj-line",
    dependencies: [{ url: "https://github.com/kana/vim-textobj-user" }],
  },
  {
    url: "https://github.com/gilligan/textobj-lastpaste",
    dependencies: [{ url: "https://github.com/kana/vim-textobj-user" }],
  },
  { url: "https://github.com/machakann/vim-swap" },
  {
    url: "https://github.com/yuki-yano/vim-textobj-generics",
    dependencies: [{ url: "https://github.com/machakann/vim-textobj-functioncall" }],
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
