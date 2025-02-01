// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2025/02/01 13:35:48.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.2";

export const fall: Plug[] = [
  {
    url: "https://github.com/vim-fall/fall.vim",
    dependencies: [
      "https://github.com/vim-denops/denops.vim",
      "https://github.com/yukimemi/chronicle.vim",
    ],
    cache: { beforeFile: "~/.config/nvim/rc/before/fall.lua" },
  },
];
