// =============================================================================
// File        : statusline.ts
// Author      : yukimemi
// Last Change : 2024/05/06 17:35:48.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.1.1";

import * as vars from "jsr:@denops/std@7.1.1/variable";
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
    url: "https://github.com/nvim-lualine/lualine.nvim",
    enabled: pluginStatus.lualine,
    afterFile: `~/.config/nvim/rc/after/lualine.lua`,
  },
  {
    url: "https://github.com/vim-airline/vim-airline",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim" && true,
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
    dependencies: [
      {
        url: "https://github.com/vim-airline/vim-airline-themes",
        after: async ({ denops }) => await vars.g.set(denops, "airline_theme", "zenburn"),
      },
    ],
  },
  {
    url: "https://github.com/itchyny/lightline.vim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim" && false,
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
  },
];
