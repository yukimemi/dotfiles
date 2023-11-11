// =============================================================================
// File        : neotree.ts
// Author      : yukimemi
// Last Change : 2023/09/23 15:46:38.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.5.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { pluginStatus } from "../main.ts";

export const neotree: Plug[] = [
  {
    url: "https://github.com/nvim-neo-tree/neo-tree.nvim",
    enabled: !pluginStatus.vscode && !pluginStatus.coc && pluginStatus.neotree,
    dependencies: [
      { url: "https://github.com/nvim-lua/plenary.nvim" },
      { url: "https://github.com/nvim-tree/nvim-web-devicons" },
      { url: "https://github.com/MunifTanjim/nui.nvim" },
      { url: "https://github.com/s1n7ax/nvim-window-picker" },
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("neo-tree").setup(_A)`, {
        filesystem: {
          window: {
            mappings: {
              "/": "noop",
              "l": "open",
            },
          },
        },
      });
      await mapping.map(
        denops,
        "<leader>e",
        `<cmd>Neotree focus filesystem left reveal_force_cwd<cr>`,
        { mode: "n" },
      );
    },
  },
];
