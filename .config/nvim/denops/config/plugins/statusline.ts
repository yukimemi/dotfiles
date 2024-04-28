// =============================================================================
// File        : statusline.ts
// Author      : yukimemi
// Last Change : 2024/03/31 10:13:39.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.10.2/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v6.4.0/autocmd/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v6.4.0/helper/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v6.4.0/lambda/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v6.4.0/variable/mod.ts";
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
            "g:spectrism_priority",
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
                await execute(
                  denops,
                  `
                    lua << EOB
                      local icon = ""
                      local bufnr = vim.fn.bufnr()
                      local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
                      local clientNames = table.concat(vim.tbl_map(function(client) return client.name end, clients), ' / ')
                      if clientNames == "" then
                        vim.g.lsp_client_names = icon .. "No LSP"
                      else
                        vim.g.lsp_client_names = icon .. clientNames
                      end
                    EOB
                  `,
                );
              },
            )
          }", [])`,
        );
      });
    },
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
        after: async ({ denops }) => {
          await vars.g.set(denops, "airline_theme", "zenburn");
        },
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
