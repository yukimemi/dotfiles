// =============================================================================
// File        : statusline.ts
// Author      : yukimemi
// Last Change : 2023/11/04 13:57:20.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.5.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.1/lambda/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/variable.ts";
import { pluginStatus } from "../main.ts";

export const statusline: Plug[] = [
  {
    url: "rebelot/heirline.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => pluginStatus.heirline && denops.meta.host === "nvim",
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
    url: "nvim-lualine/lualine.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => pluginStatus.lualine && denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("lualine").setup(_A)`, {
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
          globalstatus: true,
          refresh: {
            statusline: 1000,
            tabline: 1000,
            winbar: 1000,
          },
        },
        sections: {
          lualine_a: ["mode"],
          lualine_b: ["branch", "diff", "diagnostics"],
          lualine_c: ["filename", "location", "g:lsp_client_names"],
          lualine_x: [
            "g:colors_name",
            "g:randomcolorscheme_priority",
            "o:background",
            "encoding",
            "vim.bo.bomb and '💣' or ''",
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
          lualine_x: [],
          lualine_y: [],
          lualine_z: [],
        },
        tabline: [],
        winbar: [],
        inactive_winbar: [],
        extensions: [],
      });

      await autocmd.group(denops, "MyLualineLsp", (helper) => {
        helper.remove("*");
        helper.define(
          ["CursorHold", "LspAttach", "FocusLost"],
          "*",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                const icon = "  :";
                const bufnr = await fn.bufnr(denops);
                const clients = await denops.call(`luaeval`, `vim.lsp.get_clients(_A)`, {
                  bufnr: bufnr,
                });
                // console.log({ clients });
                // const clientNames = clients.length > 0
                //   ? clients.map((x) => x.name).join(" / ")
                //   : "None";
                // await vars.g.set(
                //   denops,
                //   "lsp_client_names",
                //   icon + clientNames,
                // );
              },
            )
          }", [])`,
        );
      });
    },
  },
  {
    url: "vim-airline/vim-airline",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim" && true,
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
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
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim" && false,
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
  },
];
