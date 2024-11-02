// =============================================================================
// File        : bluesky.ts
// Author      : yukimemi
// Last Change : 2024/08/31 15:10:42.
// =============================================================================

import * as mapping from "jsr:@denops/std@7.3.0/mapping";
import * as vars from "jsr:@denops/std@7.3.0/variable";
import type { Plug } from "jsr:@yukimemi/dvpm@5.0.13";

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
