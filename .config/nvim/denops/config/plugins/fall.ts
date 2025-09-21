// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:14:38.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

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
