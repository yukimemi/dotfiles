// =============================================================================
// File        : neotree.ts
// Author      : yukimemi
// Last Change : 2024/10/13 12:43:25.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.5.0";

import * as mapping from "jsr:@denops/std@7.4.0/mapping";
import { pluginStatus } from "../pluginstatus.ts";

export const neotree: Plug[] = [
  {
    url: "https://github.com/nvim-neo-tree/neo-tree.nvim",
    enabled: pluginStatus.neotree,
    cache: { afterFile: `~/.config/nvim/rc/after/neo-tree.lua` },
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-tree/nvim-web-devicons",
      "https://github.com/MunifTanjim/nui.nvim",
      // "https://github.com/s1n7ax/nvim-window-picker",
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
