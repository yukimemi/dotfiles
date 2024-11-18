// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2024/11/18 12:08:58.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.2.1";

export const fall: Plug[] = [
  {
    url: "https://github.com/vim-fall/vim-fall",
    dependencies: [
      "https://github.com/vim-denops/denops.vim",
      "https://github.com/yukimemi/chronicle.vim",
    ],
    cache: { beforeFile: "~/.config/nvim/rc/before/fall.lua" },
  },
];
