// =============================================================================
// File        : tmux.ts
// Author      : yukimemi
// Last Change : 2026/04/05 20:47:47.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const tmux: Plug[] = [
  {
    url: "https://github.com/christoomey/vim-tmux-navigator",
    enabled: false,
    profiles: ["core"],
  },
];
