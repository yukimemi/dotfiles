// =============================================================================
// File        : snacks.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:12:19.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus } from "../pluginstatus.ts";

export const snacks: Plug[] = [
  {
    url: "https://github.com/folke/snacks.nvim",
    enabled: pluginStatus.snacks,
    profiles: ["minimal", "core"],
    cache: { afterFile: `~/.config/nvim/rc/after/snacks.lua` },
  },
];
