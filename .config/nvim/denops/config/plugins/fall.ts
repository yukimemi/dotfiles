// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2025/10/26 18:37:54.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const fall: Plug[] = [
  {
    url: "https://github.com/mityu/vim-fall-modal",
    profiles: ["fall"],
    cache: { beforeFile: "~/.config/nvim/rc/before/vim-fall-modal.vim" },
  },
  {
    url: "https://github.com/vim-fall/fall.vim",
    profiles: ["fall"],
    dependencies: [
      "https://github.com/vim-denops/denops.vim",
      "https://github.com/yukimemi/chronicle.vim",
      "https://github.com/mityu/vim-fall-modal",
    ],
    cache: { beforeFile: "~/.config/nvim/rc/before/fall.lua" },
  },
];
