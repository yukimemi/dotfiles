// =============================================================================
// File        : quickfix.ts
// Author      : yukimemi
// Last Change : 2026/01/18 01:38:59.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus } from "../pluginstatus.ts";

export const quickfix: Plug[] = [
  {
    url: "https://github.com/kevinhwang91/nvim-bqf",
    enabled: pluginStatus.bqf,
    profiles: ["quickfix"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("bqf").setup()`);
    },
  },
  {
    url: "https://github.com/mei28/qfc.nvim",
    enabled: true,
    profiles: ["quickfix"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("qfc").setup(_A)`, {
        enabled: true,
        timeout: 30000,
      });
    },
  },
  {
    url: "https://github.com/itchyny/vim-qfedit",
    profiles: ["quickfix"],
  },
  {
    url: "https://github.com/stevearc/quicker.nvim",
    enabled: pluginStatus.quicker,
    profiles: ["quickfix"],
    afterFile: "~/.config/nvim/rc/after/quicker.lua",
  },
  {
    url: "https://github.com/r0nsha/qfpreview.nvim",
    enabled: pluginStatus.qfpreview,
    profiles: ["quickfix"],
    afterFile: "~/.config/nvim/rc/after/qfpreview.lua",
  },
  {
    url: "https://github.com/BlankTiger/aqf.nvim",
    enabled: false,
    profiles: ["quickfix"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("aqf").setup()`);
    },
  },
];
