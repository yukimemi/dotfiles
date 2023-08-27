// =============================================================================
// File        : textobj.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:38:42.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.0.8/mod.ts";

export const textobj: Plug[] = [
  {
    url: "kana/vim-textobj-entire",
    dependencies: [{ url: "kana/vim-textobj-user" }],
  },
  {
    url: "kana/vim-textobj-indent",
    dependencies: [{ url: "kana/vim-textobj-user" }],
  },
  {
    url: "kana/vim-textobj-line",
    dependencies: [{ url: "kana/vim-textobj-user" }],
  },
  {
    url: "gilligan/textobj-lastpaste",
    dependencies: [{ url: "kana/vim-textobj-user" }],
  },
  { url: "machakann/vim-swap" },
  {
    url: "yuki-yano/vim-textobj-generics",
    dependencies: [{ url: "machakann/vim-textobj-functioncall" }],
  },
];
