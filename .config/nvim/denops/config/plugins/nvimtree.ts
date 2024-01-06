// =============================================================================
// File        : nvimtree.ts
// Author      : yukimemi
// Last Change : 2023/08/26 16:56:15.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.2.0/mapping/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const nvimtree: Plug[] = [
  {
    url: "https://github.com/nvim-tree/nvim-tree.lua",
    enabled: !pluginStatus.vscode && !pluginStatus.coc && pluginStatus.nvimtree,
    dependencies: [
      { url: "https://github.com/nvim-tree/nvim-web-devicons" },
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
