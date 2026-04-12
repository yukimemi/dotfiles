// =============================================================================
// File        : compl.ts
// Author      : yukimemi
// Last Change : 2026/01/17 21:47:43.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { selections } from "../pluginstatus.ts";

export const compl: Plug[] = [
  {
    url: "https://github.com/brianaung/compl.nvim",
    enabled: selections.completion === "compl",
    profiles: ["completion"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/compl.lua`,
  },
];
