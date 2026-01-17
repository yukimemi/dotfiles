// =============================================================================
// File        : fun.ts
// Author      : yukimemi
// Last Change : 2026/01/17 11:28:53
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const fun: Plug[] = [
  {
    url: "https://github.com/frostzt/bongo-cat.nvim",
    profiles: ["fun"],
    lazy: {
      cmd: [
        "BongoCat",
        "BongoCatShow",
        "BongoCatHide",
        "BongoCatStats",
      ],
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("bongo-cat").setup(_A)`, {});
    },
  },
];
