// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2024/11/24 20:38:36.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.5.1";

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
