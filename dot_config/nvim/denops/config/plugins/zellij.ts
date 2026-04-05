// =============================================================================
// File        : zellij.ts
// Author      : yukimemi
// Last Change : 2026/04/05 16:40:00
// =============================================================================
import type { Plug } from "@yukimemi/dvpm";
import * as mapping from "@denops/std/mapping";
import * as autocmd from "@denops/std/autocmd";
import * as fn from "@denops/std/function";
export const zellij: Plug[] = [
  {
    url: "https://github.com/mrjones2014/smart-splits.nvim",
    profiles: ["window"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("smart-splits").setup()`);
      // Zellij Auto-lock integration via Denops API
      await autocmd.group(denops, "MyZellij", (helper) => {
        helper.remove("*");
        helper.define(
          ["VimEnter", "FocusGained"],
          "*",
          `silent! !zellij action switch-mode locked`,
        );
        helper.define(
          ["VimLeave", "FocusLost"],
          "*",
          `silent! !zellij action switch-mode normal`,
        );
      });
      // Lock immediately if already inside Zellij
      if (await fn.exists(denops, "$ZELLIJ")) {
        await denops.cmd(`silent! !zellij action switch-mode locked`);
      }
      // Mappings for smart-splits (integrated with Zellij via its own API)
      for (const dir of ["left", "down", "up", "right"]) {
        const key = dir === "left"
          ? "h"
          : dir === "down"
          ? "j"
          : dir === "up"
          ? "k"
          : "l";
        await mapping.map(
          denops,
          `<C-${key}>`,
          `<cmd>lua require("smart-splits").move_cursor_${dir}()<cr>`,
          {
            mode: "n",
            silent: true,
          },
        );
      }
    },
  },
];
