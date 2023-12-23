// =============================================================================
// File        : neotree.ts
// Author      : yukimemi
// Last Change : 2023/12/23 21:07:37.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.6.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.2.0/mapping/mod.ts";
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
          filtered_items: {
            hide_dotfiles: false,
            hide_gitignored: true,
            hide_hidden: false,
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
