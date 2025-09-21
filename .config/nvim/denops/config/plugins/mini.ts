// =============================================================================
// File        : mini.ts
// Author      : yukimemi
// Last Change : 2025/09/21 13:28:08.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";
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
