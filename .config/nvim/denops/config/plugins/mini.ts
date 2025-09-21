// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2025/09/18 21:29:48.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";

export const mini: Plug[] = [
  {
    url: "https://github.com/nvim-mini/mini.nvim",
    dependencies: ["https://github.com/yukimemi/chronicle.vim"],
    profiles: ["mini"],
    cache: { afterFile: `~/.config/nvim/rc/after/mini.lua` },
  },
];
