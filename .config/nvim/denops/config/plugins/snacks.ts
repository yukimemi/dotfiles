// =============================================================================
// File        : snacks.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:12:19.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus, selections } from "../pluginstatus.ts";

export const snacks: Plug[] = [
  {
    url: "https://github.com/folke/snacks.nvim",
    enabled: selections.ff === "snacks" || pluginStatus.snacks,
    profiles: ["core"],
    cache: { afterFile: `~/.config/nvim/rc/after/snacks.lua` },
  },
];
