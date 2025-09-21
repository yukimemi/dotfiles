// =============================================================================
// File        : snacks.ts
// Author      : yukimemi
// Last Change : 2025/09/18 21:29:27.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";

export const snacks: Plug[] = [
  {
    url: "https://github.com/folke/snacks.nvim",
    profiles: ["minimal", "core"],
    cache: { afterFile: `~/.config/nvim/rc/after/snacks.lua` },
  },
];
