// =============================================================================
// File        : tmux.ts
// Author      : yukimemi
// Last Change : 2025/01/26 11:38:38.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.0";

export const tmux: Plug[] = [
  {
    url: "https://github.com/christoomey/vim-tmux-navigator",
    profiles: ["default"],
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.platform !== "windows",
  },
];
