// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2025/10/27 17:11:23.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const fall: Plug[] = [
  {
    url: "https://github.com/mityu/vim-fall-modal",
    profiles: ["fall"],
    beforeFile: "~/.config/nvim/rc/before/vim-fall-modal.vim",
  },
  {
    url: "https://github.com/vim-fall/fall.vim",
    profiles: ["fall"],
    dependencies: [
      "https://github.com/vim-denops/denops.vim",
      "https://github.com/yukimemi/chronicle.vim",
      "https://github.com/mityu/vim-fall-modal",
    ],
    beforeFile: "~/.config/nvim/rc/before/fall.lua",
  },
];
