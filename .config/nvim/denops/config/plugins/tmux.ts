// =============================================================================
// File        : tmux.ts
// Author      : yukimemi
// Last Change : 2023/08/26 13:16:46.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.2.0";

export const tmux: Plug[] = [
  {
    url: "https://github.com/christoomey/vim-tmux-navigator",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.platform !== "windows",
  },
];
