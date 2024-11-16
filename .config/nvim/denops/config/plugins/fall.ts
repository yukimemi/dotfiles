// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2024/11/16 13:28:14.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.14";

export const fall: Plug[] = [
  { url: "https://github.com/lambdalisue/vim-fall-source-mr" },
  {
    url: "https://github.com/vim-fall/vim-fall",
    dependencies: [
      "https://github.com/vim-denops/denops.vim",
      "https://github.com/lambdalisue/vim-fall-source-mr",
    ],
    cache: { beforeFile: "~/.config/nvim/rc/before/fall.lua" },
  },
];
