// =============================================================================
// File        : chezmoi.ts
// Author      : yukimemi
// Last Change : 2026/01/25 21:50:43.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const chezmoi: Plug[] = [
  {
    url: "https://github.com/xvzc/chezmoi.nvim",
    profiles: ["core"],
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
    ],
    lazy: {
      keys: [
        {
          lhs: "md",
          rhs: '<cmd>lua require("chezmoi.pick").snacks()<cr>',
          desc: "Chezmoi files",
          mode: "n",
        },
      ],
      event: ["BufRead", "BufNewFile"],
    },
    addFile: "~/.config/nvim/rc/add/chezmoi.lua",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("chezmoi").setup(_A)`, {
        edit: {
          watch: true,
          force: false,
          ignore_patterns: [
            "run_onchange_.*",
            "run_once_.*",
            "%.chezmoiignore",
            "%.chezmoitemplate",
          ],
        },
        events: {
          on_open: {
            notification: { enable: true },
          },
          on_watch: {
            notification: { enable: true },
          },
          on_apply: {
            notification: { enable: true },
          },
        },
      });
    },
  },
  {
    url: "https://github.com/alker0/chezmoi.vim",
    profiles: ["core"],
    lazy: {
      event: "BufRead",
    },
  },
];
