// =============================================================================
// File        : zellij.ts
// Author      : yukimemi
// Last Change : 2026/04/05 16:40:00
// =============================================================================
import type { Plug } from "@yukimemi/dvpm";
export const zellij: Plug[] = [
  {
    url: "https://github.com/mrjones2014/smart-splits.nvim",
    profiles: ["window"],
    after: async ({ denops }) => {
      // Initialize smart-splits (for resize and other features)
      // ctrl-h/j/k/l navigation is handled by tmux_move in cache.ts
      // which supports neovim windows, zellij panes, and tmux panes.
      await denops.call(`luaeval`, `require("smart-splits").setup()`);
    },
  },
];
