import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.5/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.0/lambda/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v5.0.0/batch/mod.ts";
import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";
import { pluginStatus } from "../main.ts";

export const lsp: Plug[] = [
  {
    url: "neovim/nvim-lspconfig",
    dependencies: [
      { url: "SmiteshP/nvim-navic" },
      { url: "lukas-reineke/lsp-format.nvim" },
      { url: "jose-elias-alvarez/null-ls.nvim" },
      { url: "williamboman/mason.nvim" },
      { url: "williamboman/mason-lspconfig.nvim" },
      {
        url: "folke/neodev.nvim",
        after: async (denops: Denops) => {
          await denops.call(`luaeval`, `require("neodev").setup(_A.param)`, {
            param: {
              library: {
                plugins: ["nvim-dap-ui"],
                types: true,
              },
            },
          });
        },
      },
      {
        url: "folke/neoconf.nvim",
        after: async (denops: Denops) => {
          await denops.cmd(`lua require("neoconf").setup()`);
        },
      },
      {
        url: "onsails/lspkind.nvim",
        after: async (denops: Denops) => {
          await denops.call(`luaeval`, `require("lspkind").setup(_A.param)`, {
            param: {
              // defines how annotations are shown
              // default: symbol
              // options: 'text', 'text_symbol', 'symbol_text', 'symbol'
              mode: "symbol_text",

              // default symbol map
              // can be either 'default' (requires nerd-fonts font) or
              // 'codicons' for codicon preset (requires vscode-codicons font)
              //
              // default: 'default'
              preset: "codicons",

              // override preset symbols
              //
              // default: {}
              symbol_map: {
                Text: "",
                Method: "",
                Function: "",
                Constructor: "",
                Field: "ﰠ",
                Variable: "",
                Class: "ﴯ",
                Interface: "",
                Module: "",
                Property: "ﰠ",
                Unit: "塞",
                Value: "",
                Enum: "",
                Keyword: "",
                Snippet: "",
                Color: "",
                File: "",
                Reference: "",
                Folder: "",
                EnumMember: "",
                Constant: "",
                Struct: "פּ",
                Event: "",
                Operator: "",
                TypeParameter: "",
              },
            },
          });
        },
      },
    ],
    after: async (denops: Denops) => {
      await denops.call(`luaeval`, `require("mason").setup(_A.param)`, {
        param: {
          providers: ["mason.providers.client", "mason.providers.registry-api"],
        },
      });
      await denops.cmd(`lua require("masonlspconfig").setup()`);

      const onAttach = lambda.register(denops, async (client, bufnr) => {
        await denops.call(
          `luaeval`,
          `require("nvim-navic").setup(_A.client, _A.bufnr)`,
          {
            client,
            bufnr,
          }
        );
        await denops.call(
          `luaeval`,
          `require("lsp-format").setup(_A.client, _A.bufnr)`,
          {
            client,
            bufnr,
          }
        );
      });
    },
  },
];
