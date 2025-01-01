// =============================================================================
// File        : tmux.ts
// Author      : yukimemi
// Last Change : 2025/01/02 01:29:40.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.8.0";

export const tmux: Plug[] = [
  {
    url: "https://github.com/christoomey/vim-tmux-navigator",
    profiles: ["default"],
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.platform !== "windows",
  },
];
