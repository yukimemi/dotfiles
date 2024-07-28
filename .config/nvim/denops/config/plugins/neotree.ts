// =============================================================================
// File        : neotree.ts
// Author      : yukimemi
// Last Change : 2024/07/27 22:27:35.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";

import * as mapping from "jsr:@denops/std@7.0.0/mapping";
import { pluginStatus } from "../pluginstatus.ts";

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
