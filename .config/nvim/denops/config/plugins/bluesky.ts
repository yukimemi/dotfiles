// =============================================================================
// File        : bluesky.ts
// Author      : yukimemi
// Last Change : 2025/01/02 21:42:56.
// =============================================================================

import * as mapping from "jsr:@denops/std@7.4.0/mapping";
import * as vars from "jsr:@denops/std@7.4.0/variable";
import type { Plug } from "jsr:@yukimemi/dvpm@6.0.2";

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
