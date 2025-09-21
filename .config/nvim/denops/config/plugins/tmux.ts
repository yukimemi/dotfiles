// =============================================================================
// File        : tmux.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:11:02.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const tmux: Plug[] = [
  {
    url: "https://github.com/christoomey/vim-tmux-navigator",
    profiles: ["default"],
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.platform !== "windows",
  },
];
