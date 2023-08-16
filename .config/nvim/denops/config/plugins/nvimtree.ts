// =============================================================================
// File        : nvimtree.ts
// Author      : yukimemi
// Last Change : 2023/08/05 23:34:40.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.0.2/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { pluginStatus } from "../main.ts";

export const nvimtree: Plug[] = [
  {
    url: "nvim-tree/nvim-tree.lua",
    enabled: !pluginStatus.vscode && pluginStatus.nvimtree,
    dependencies: [
      { url: "nvim-tree/nvim-web-devicons" },
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("nvim-tree").setup()`);
      await mapping.map(
        denops,
        "<leader>e",
        `<cmd>NvimTreeFindFile<cr>`,
        { mode: "n" },
      );
    },
  },
];
