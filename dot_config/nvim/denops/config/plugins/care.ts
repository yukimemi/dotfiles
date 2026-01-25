// =============================================================================
// File        : care.ts
// Author      : yukimemi
// Last Change : 2026/01/17 21:47:15.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { selections } from "../pluginstatus.ts";

export const care: Plug[] = [
  {
    url: "https://github.com/max397574/care.nvim",
    enabled: selections.completion === "care",
    profiles: ["completion"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/care.lua`,
  },
];
