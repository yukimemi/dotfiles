// =============================================================================
// File        : tmux.ts
// Author      : yukimemi
// Last Change : 2026/01/25 20:52:29.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const tmux: Plug[] = [
  {
    url: "https://github.com/christoomey/vim-tmux-navigator",
    enabled: Deno.build.os !== "windows",
    profiles: ["core"],
  },
];
