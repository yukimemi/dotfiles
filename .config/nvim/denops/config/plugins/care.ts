// =============================================================================
// File        : care.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:18:27.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const care: Plug[] = [
  {
    url: "https://github.com/max397574/care.nvim",
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/care.lua`,
  },
];
