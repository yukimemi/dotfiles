import type { Plug } from "https://deno.land/x/dvpm@0.3.8/mod.ts";

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
];
