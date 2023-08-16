// =============================================================================
// File        : neotree.ts
// Author      : yukimemi
// Last Change : 2023/08/05 23:21:09.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.0.2/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { pluginStatus } from "../main.ts";

export const neotree: Plug[] = [
  {
    url: "nvim-neo-tree/neo-tree.nvim",
    enabled: !pluginStatus.vscode && pluginStatus.neotree,
    dependencies: [
      { url: "nvim-lua/plenary.nvim" },
      { url: "nvim-tree/nvim-web-devicons" },
      { url: "MunifTanjim/nui.nvim" },
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("neo-tree").setup()`);
      await mapping.map(
        denops,
        "<leader>e",
        `<cmd>Neotree filesystem reveal left<cr>`,
        { mode: "n" },
      );
    },
  },
];
