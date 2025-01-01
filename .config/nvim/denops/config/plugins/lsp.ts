// =============================================================================
// File        : lsp.ts
// Author      : yukimemi
// Last Change : 2024/11/08 17:59:13.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.6.0";

import { pluginStatus } from "../pluginstatus.ts";

export const lsp: Plug[] = [
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
  {
    url: "https://github.com/SmiteshP/nvim-navic",
  },
  {
    url: "https://github.com/stevearc/aerial.nvim",
    afterFile: `~/.config/nvim/rc/after/aerial.lua`,
  },
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
    enabled: false,
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    afterFile: "~/.config/nvim/rc/after/none-ls.lua",
  },
  { url: "https://github.com/williamboman/mason.nvim" },
  {
    url: "https://github.com/williamboman/mason-lspconfig.nvim",
    dependencies: [
      "https://github.com/williamboman/mason.nvim",
    ],
  },
  {
    url: "https://github.com/zapling/mason-conform.nvim",
    enabled: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("mason-conform").setup()`);
    },
  },
  {
    url: "https://github.com/folke/lazydev.nvim",
    dependencies: ["https://github.com/neovim/nvim-lspconfig"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("lazydev").setup()`);
    },
  },
  { url: "https://github.com/folke/neoconf.nvim" },
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
      "https://github.com/neovim/nvim-lspconfig",
      "https://github.com/SmiteshP/nvim-navic",
    ],
  },
  {
    url: "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("tiny-inline-diagnostic").setup()`);
    },
  },
  {
    url: "https://github.com/chrisgrieser/nvim-lsp-endhints",
    afterFile: `~/.config/nvim/rc/after/nvim-lsp-endhints.lua`,
  },
  {
    url: "https://github.com/folke/trouble.nvim",
    profiles: ["minimal"],
  },
  {
    url: "https://github.com/neovim/nvim-lspconfig",
    enabled: !pluginStatus.coc,
    dependencies: [
      "https://github.com/SmiteshP/nvim-navic",
      "https://github.com/folke/neoconf.nvim",
      "https://github.com/folke/trouble.nvim",
      "https://github.com/onsails/lspkind.nvim",
      "https://github.com/williamboman/mason-lspconfig.nvim",
      "https://github.com/williamboman/mason.nvim",
      // "https://github.com/Saghen/blink.cmp",
      // "https://github.com/nvimtools/none-ls.nvim",
      // "https://github.com/zapling/mason-conform.nvim",
    ],
    afterFile: "~/.config/nvim/rc/after/nvim-lspconfig.lua",
  },
];
