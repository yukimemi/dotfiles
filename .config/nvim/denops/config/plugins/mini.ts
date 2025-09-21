// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:13:22.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus } from "../pluginstatus.ts";

export const mini: Plug[] = [
  {
    url: "https://github.com/nvim-mini/mini.nvim",
    enabled: pluginStatus.mini,
    dependencies: ["https://github.com/yukimemi/chronicle.vim"],
    profiles: ["mini", "core"],
    cache: { afterFile: `~/.config/nvim/rc/after/mini.lua` },
  },
];
