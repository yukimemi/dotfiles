// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2025/12/28 14:14:02.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus } from "../pluginstatus.ts";

export const mini: Plug[] = [
  {
    url: "https://github.com/nvim-mini/mini.nvim",
    enabled: pluginStatus.mini,
    profiles: ["mini"],
    dependencies: ["https://github.com/yukimemi/chronicle.vim"],
    cache: { afterFile: `~/.config/nvim/rc/after/mini.lua` },
  },
];
