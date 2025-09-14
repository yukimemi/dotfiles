// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2025/09/14 13:08:35.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";

export const mini: Plug[] = [
  {
    url: "https://github.com/nvim-mini/mini.nvim",
    dependencies: ["https://github.com/yukimemi/chronicle.vim"],
    profiles: ["mini", "core"],
    cache: { afterFile: `~/.config/nvim/rc/after/mini.lua` },
  },
];
