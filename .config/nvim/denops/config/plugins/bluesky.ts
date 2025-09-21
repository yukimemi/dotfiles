// =============================================================================
// File        : bluesky.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:18:36.
// =============================================================================

import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";
import type { Plug } from "@yukimemi/dvpm";

export const bluesky: Plug[] = [
  {
    url: "https://github.com/basyura/dsky.vim",
    after: async ({ denops }) => {
      await vars.g.set(denops, "dsky_id", "yukimemi");
      await vars.g.set(denops, "dsky_password", Deno.env.get("DSKY_PASSWORD"));

      await mapping.map(denops, "<space>Th", "<cmd>DSkyTimeline<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>Tm", "<cmd>DSkyNotifications<cr>", {
        mode: "n",
      });
    },
  },
];
