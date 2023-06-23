import type { Plug } from "https://deno.land/x/dvpm@1.3.0/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";

import { pluginStatus } from "../main.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/variable.ts";

export const statusline: Plug[] = [
  {
    url: "rebelot/heirline.nvim",
    enabled: async ({ denops }) =>
      pluginStatus.heirline && await fn.has(denops, "nvim"),
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("heirline").setup(_A.param)`, {
        param: {
          statusline: {},
          winbar: {},
          tabline: {},
          statuscolumn: {},
        },
      });
    },
  },
  {
    url: "nvim-lualine/lualine.nvim",
    enabled: async ({ denops }) =>
      pluginStatus.lualine && await fn.has(denops, "nvim"),
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("lualine").setup(_A.param)`, {
        param: {
          options: {
            icons_enabled: true,
            theme: "auto",
            component_separators: { left: "", right: "" },
            section_separators: { left: "", right: "" },
            disabled_filetypes: {
              statusline: [],
              winbar: [],
            },
            ignore_focus: [],
            always_divide_middle: true,
            globalstatus: false,
            refresh: {
              statusline: 1000,
              tabline: 1000,
              winbar: 1000,
            },
          },
          sections: {
            lualine_a: ["mode"],
            lualine_b: ["branch", "diff", "diagnostics"],
            lualine_c: ["filename"],
            lualine_x: [
              "g:colors_name",
              "g:randomcolorscheme_priority",
              "encoding",
              "fileformat",
              "filetype",
            ],
            lualine_y: ["progress"],
            lualine_z: ["location"],
          },
          inactive_sections: {
            lualine_a: [],
            lualine_b: [],
            lualine_c: ["filename"],
            lualine_x: ["location"],
            lualine_y: [],
            lualine_z: [],
          },
          tabline: [],
          winbar: [],
          inactive_winbar: [],
          extensions: [],
        },
      });
    },
  },
  {
    url: "vim-airline/vim-airline",
    enabled: async ({ denops }) => !(await fn.has(denops, "nvim")) && true,
    dependencies: [
      {
        url: "vim-airline/vim-airline-themes",
        after: async ({ denops }) => {
          await globals.set(denops, "airline_theme", "zenburn");
        },
      },
    ],
  },
  {
    url: "itchyny/lightline.vim",
    enabled: async ({ denops }) => !(await fn.has(denops, "nvim")) && false,
  },
];
