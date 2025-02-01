// =============================================================================
// File        : statusline.ts
// Author      : yukimemi
// Last Change : 2025/01/26 11:38:42.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.2";

import { pluginStatus } from "../pluginstatus.ts";

export const statusline: Plug[] = [
  {
    url: "https://github.com/rebelot/heirline.nvim",
    enabled: pluginStatus.heirline,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("heirline").setup(_A)`, {
        statusline: {},
        winbar: {},
        tabline: {},
        statuscolumn: {},
      });
    },
  },
  {
    url: "https://github.com/pnx/lualine-lsp-status",
    profiles: ["default"],
    enabled: pluginStatus.lualine,
  },
  {
    url: "https://github.com/nvim-lualine/lualine.nvim",
    profiles: ["default"],
    enabled: pluginStatus.lualine,
    dependencies: [
      "https://github.com/pnx/lualine-lsp-status",
    ],
    afterFile: `~/.config/nvim/rc/after/lualine.lua`,
  },
  {
    url: "https://github.com/itchyny/lightline.vim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim" && false,
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
  },
];
