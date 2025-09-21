// =============================================================================
// File        : snacks.ts
// Author      : yukimemi
// Last Change : 2025/09/21 13:27:32.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";
import { pluginStatus } from "../pluginstatus.ts";

export const snacks: Plug[] = [
  {
    url: "https://github.com/folke/snacks.nvim",
    enabled: pluginStatus.snacks,
    profiles: ["minimal", "core"],
    cache: { afterFile: `~/.config/nvim/rc/after/snacks.lua` },
  },
];
