// =============================================================================
// File        : tmux.ts
// Author      : yukimemi
// Last Change : 2025/11/29 07:36:42.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const tmux: Plug[] = [
  {
    url: "https://github.com/christoomey/vim-tmux-navigator",
    profiles: ["core"],
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.platform !== "windows",
  },
];
