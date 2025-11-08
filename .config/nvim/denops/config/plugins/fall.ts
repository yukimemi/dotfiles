// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2025/11/08 15:51:42.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const fall: Plug[] = [
  {
    url: "https://github.com/mityu/vim-fall-modal",
    profiles: ["ff"],
    beforeFile: "~/.config/nvim/rc/before/vim-fall-modal.vim",
  },
  {
    url: "https://github.com/vim-fall/fall.vim",
    profiles: ["ff"],
    dependencies: [
      "https://github.com/vim-denops/denops.vim",
      "https://github.com/yukimemi/chronicle.vim",
      "https://github.com/mityu/vim-fall-modal",
    ],
    beforeFile: "~/.config/nvim/rc/before/fall.lua",
  },
];
