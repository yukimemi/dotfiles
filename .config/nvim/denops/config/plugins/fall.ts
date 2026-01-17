// =============================================================================
// File        : fall.ts
// Author      : yukimemi
// Last Change : 2026/01/17 21:49:41.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { selections } from "../pluginstatus.ts";

export const fall: Plug[] = [
  {
    url: "https://github.com/mityu/vim-fall-modal",
    enabled: selections.ff === "fall",
    profiles: ["ff"],
    beforeFile: "~/.config/nvim/rc/before/vim-fall-modal.vim",
  },
  {
    url: "https://github.com/vim-fall/fall.vim",
    enabled: selections.ff === "fall",
    profiles: ["ff"],
    dependencies: [
      "https://github.com/vim-denops/denops.vim",
      "https://github.com/yukimemi/chronicle.vim",
      "https://github.com/mityu/vim-fall-modal",
    ],
    beforeFile: "~/.config/nvim/rc/before/fall.lua",
  },
];
