// =============================================================================
// File        : care.ts
// Author      : yukimemi
// Last Change : 2025/12/01 00:47:31.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const care: Plug[] = [
  {
    url: "https://github.com/max397574/care.nvim",
    profiles: ["completion"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/care.lua`,
  },
];
