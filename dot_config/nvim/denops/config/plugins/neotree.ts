// =============================================================================
// File        : neotree.ts
// Author      : yukimemi
// Last Change : 2026/01/17 21:58:30.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as mapping from "@denops/std/mapping";
import { selections } from "../pluginstatus.ts";

export const neotree: Plug[] = [
  {
    url: "https://github.com/nvim-neo-tree/neo-tree.nvim",
    enabled: selections.filer === "neotree",
    profiles: ["filer"],
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-tree/nvim-web-devicons",
      "https://github.com/MunifTanjim/nui.nvim",
    ],
    cache: { afterFile: `~/.config/nvim/rc/after/neo-tree.lua` },
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
        "ge",
        `<cmd>Neotree focus filesystem left reveal_force_cwd<cr>`,
        { mode: "n" },
      );
    },
  },
];
