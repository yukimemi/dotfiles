// =============================================================================
// File        : statusline.ts
// Author      : yukimemi
// Last Change : 2024/05/06 17:35:48.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.15.1/mod.ts";

import * as vars from "https://deno.land/x/denops_std@v6.5.1/variable/mod.ts";
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
