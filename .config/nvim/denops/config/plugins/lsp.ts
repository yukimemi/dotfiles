// =============================================================================
// File        : lsp.ts
// Author      : yukimemi
// Last Change : 2025/06/30 10:36:45.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.0";

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
    profiles: ["full"],
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
    profiles: ["lsp"],
    enabled: false,
  },
  {
    url: "https://github.com/stevearc/aerial.nvim",
    profiles: ["lsp"],
    afterFile: `~/.config/nvim/rc/after/aerial.lua`,
  },
  {
    url: "https://github.com/stevearc/conform.nvim",
    profiles: ["lsp"],
    afterFile: "~/.config/nvim/rc/after/conform.lua",
  },
  {
    url: "https://github.com/mfussenegger/nvim-lint",
    profiles: ["lsp"],
    afterFile: "~/.config/nvim/rc/after/nvim-lint.lua",
  },
  {
    url: "https://github.com/nvimtools/none-ls.nvim",
    enabled: false,
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    afterFile: "~/.config/nvim/rc/after/none-ls.lua",
  },
  {
    url: "https://github.com/williamboman/mason.nvim",
    profiles: ["lsp"],
  },
  {
    url: "https://github.com/williamboman/mason-lspconfig.nvim",
    profiles: ["lsp"],
    dependencies: [
      "https://github.com/williamboman/mason.nvim",
    ],
    afterFile: "~/.config/nvim/rc/after/mason-lspconfig.lua",
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
    profiles: ["lsp"],
    dependencies: ["https://github.com/neovim/nvim-lspconfig"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("lazydev").setup()`);
    },
  },
  {
    url: "https://github.com/folke/neoconf.nvim",
    profiles: ["lsp"],
  },
  {
    url: "https://github.com/onsails/lspkind.nvim",
    profiles: ["lsp"],
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
    profiles: ["rust"],
    afterFile: "~/.config/nvim/rc/after/rustaceanvim.lua",
    dependencies: [
      "https://github.com/neovim/nvim-lspconfig",
      "https://github.com/SmiteshP/nvim-navic",
    ],
  },
  {
    url: "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
    profiles: ["lsp"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("tiny-inline-diagnostic").setup()`);
    },
  },
  {
    url: "https://github.com/chrisgrieser/nvim-lsp-endhints",
    profiles: ["lsp"],
    afterFile: `~/.config/nvim/rc/after/nvim-lsp-endhints.lua`,
  },
  {
    url: "https://github.com/folke/trouble.nvim",
    profiles: ["minimal"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("trouble").setup()`);
    },
  },
  {
    url: "https://github.com/neovim/nvim-lspconfig",
    profiles: ["lsp"],
    dependencies: [
      "https://github.com/SmiteshP/nvim-navic",
      "https://github.com/folke/neoconf.nvim",
      "https://github.com/folke/trouble.nvim",
      "https://github.com/hrsh7th/nvim-cmp",
      // "https://github.com/Saghen/blink.cmp",
      "https://github.com/onsails/lspkind.nvim",
      "https://github.com/williamboman/mason-lspconfig.nvim",
      "https://github.com/williamboman/mason.nvim",
    ],
    afterFile: "~/.config/nvim/rc/after/nvim-lspconfig.lua",
  },
];
