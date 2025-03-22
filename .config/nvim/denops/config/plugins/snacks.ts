// =============================================================================
// File        : snacks.ts
// Author      : yukimemi
// Last Change : 2025/02/07 00:02:53.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.2";

export const snacks: Plug[] = [
  {
    url: "https://github.com/folke/snacks.nvim",
    profiles: ["minimal"],
    cache: { afterFile: `~/.config/nvim/rc/after/snacks.lua` },
  },
];
