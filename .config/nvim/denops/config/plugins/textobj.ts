// =============================================================================
// File        : textobj.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:38:42.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.9.0/mod.ts";

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
];
