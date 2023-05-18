import type { Plug } from "https://deno.land/x/dvpm@0.1.1/mod.ts";

export const textobj: Plug[] = [
  { url: "kana/vim-textobj-user" },
  { url: "kana/vim-textobj-entire" },
  { url: "kana/vim-textobj-indent" },
  { url: "kana/vim-textobj-line" },
  { url: "gilligan/textobj-lastpaste" },
];
