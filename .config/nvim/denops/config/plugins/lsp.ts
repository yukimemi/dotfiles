// =============================================================================
// File        : lsp.ts
// Author      : yukimemi
// Last Change : 2024/06/08 21:07:25.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.12.0/mod.ts";

import { pluginStatus } from "../pluginstatus.ts";

export const lsp: Plug[] = [
  {
    url: "https://github.com/neovim/nvim-lspconfig",
    enabled: !pluginStatus.coc && !pluginStatus.vscode,
    dependencies: [
      {
        url: "https://github.com/zbirenbaum/neodim",
        enabled: false,
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("neodim").setup()`);
        },
      },
      {
        url: "https://github.com/hrsh7th/nvim-linkedit",
        after: async ({ denops }) => {
          await denops.call(
            `luaeval`,
            `require("linkedit").setup(_A)`,
            {
              enabled: true,
              fetch_timeout: 200,
              keyword_pattern: `\k*`,
            },
          );
        },
      },
      { url: "https://github.com/SmiteshP/nvim-navic" },
      {
        url: "https://github.com/stevearc/aerial.nvim",
        afterFile: `~/.config/nvim/rc/after/aerial.lua`,
      },
      { url: "https://git.sr.ht/~whynothugo/lsp_lines.nvim", enabled: false },
      { url: "https://github.com/lukas-reineke/lsp-format.nvim", enabled: false },
      {
        url: "https://github.com/stevearc/conform.nvim",
        afterFile: "~/.config/nvim/rc/after/conform.lua",
      },
      {
        url: "https://github.com/mfussenegger/nvim-lint",
        afterFile: "~/.config/nvim/rc/after/nvim-lint.lua",
      },
      {
        url: "https://github.com/nvimtools/none-ls.nvim",
        dependencies: [{ url: "https://github.com/nvim-lua/plenary.nvim" }],
        afterFile: "~/.config/nvim/rc/after/none-ls.lua",
      },
      { url: "https://github.com/williamboman/mason.nvim" },
      {
        url: "https://github.com/williamboman/mason-lspconfig.nvim",
        dependencies: [
          { url: "https://github.com/neovim/nvim-lspconfig" },
          { url: "https://github.com/williamboman/mason.nvim" },
        ],
      },
      {
        url: "https://github.com/zapling/mason-conform.nvim",
        enabled: false,
        after: async ({ denops }) => {
          await denops.cmd(`lua require("mason-conform").setup()`);
        },
      },
      {
        url: "https://github.com/folke/lazydev.nvim",
        dependencies: [{ url: "https://github.com/neovim/nvim-lspconfig" }],
        after: async ({ denops }) => {
          await denops.cmd(`lua require("lazydev").setup()`);
        },
      },
      {
        url: "https://github.com/folke/neoconf.nvim",
        dependencies: [{ url: "https://github.com/neovim/nvim-lspconfig" }],
        after: async ({ denops }) => {
          await denops.cmd(`lua require("neoconf").setup()`);
        },
      },
      {
        url: "https://github.com/onsails/lspkind.nvim",
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("lspkind").init(_A)`, {
            // defines how annotations are shown
            // default: symbol
            // options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            mode: "symbol",

            // default symbol map
            // can be either 'default' (requires nerd-fonts font) or
            // 'codicons' for codicon preset (requires vscode-codicons font)
            //
            // default: 'default'
            preset: "default",
          });
        },
      },
      {
        url: "https://github.com/mrcjkb/rustaceanvim",
        afterFile: "~/.config/nvim/rc/after/rustaceanvim.lua",
        dependencies: [
          { url: "https://github.com/neovim/nvim-lspconfig" },
          { url: "https://github.com/SmiteshP/nvim-navic" },
        ],
      },
    ],
    afterFile: "~/.config/nvim/rc/after/nvim-lspconfig.lua",
  },
];
