// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2025/08/03 14:26:48.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";

export const fall: Plug[] = [
  {
    url: "https://github.com/vim-fall/fall.vim",
    profiles: ["fall"],
    dependencies: [
      "https://github.com/vim-denops/denops.vim",
      "https://github.com/yukimemi/chronicle.vim",
    ],
    cache: { beforeFile: "~/.config/nvim/rc/before/fall.lua" },
  },
];
