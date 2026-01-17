// =============================================================================
// File        : lsp.ts
// Author      : yukimemi
// Last Change : 2026/01/18 01:36:55.
// =============================================================================

import { execute } from "@denops/std/helper";
import type { Plug } from "@yukimemi/dvpm";
import { selections } from "../pluginstatus.ts";

const lspDependencies = [
  "https://github.com/alexpasmantier/krust.nvim",
  "https://github.com/SmiteshP/nvim-navic",
  "https://github.com/folke/neoconf.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/onsails/lspkind.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/williamboman/mason.nvim",
];

export const lsp: Plug[] = [
  {
    url: "https://github.com/zbirenbaum/neodim",
    enabled: false,
    profiles: ["lsp"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("neodim").setup()`);
    },
  },
  {
    url: "https://github.com/hrsh7th/nvim-linkedit",
    profiles: ["lsp"],
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
    enabled: false,
    profiles: ["lsp"],
  },
  {
    url: "https://github.com/stevearc/aerial.nvim",
    profiles: ["lsp"],
    lazy: {
      cmd: "AerialToggle",
    },
    afterFile: `~/.config/nvim/rc/after/aerial.lua`,
  },
  {
    url: "https://github.com/stevearc/conform.nvim",
    profiles: ["lsp"],
    lazy: {
      event: ["BufRead", "BufNewFile"],
    },
    afterFile: "~/.config/nvim/rc/after/conform.lua",
  },
  {
    url: "https://github.com/mfussenegger/nvim-lint",
    profiles: ["lsp"],
    lazy: {
      event: ["BufRead", "BufNewFile"],
    },
    afterFile: "~/.config/nvim/rc/after/nvim-lint.lua",
  },
  {
    url: "https://github.com/nvimtools/none-ls.nvim",
    enabled: false,
    profiles: ["lsp"],
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    afterFile: "~/.config/nvim/rc/after/none-ls.lua",
  },
  {
    url: "https://github.com/williamboman/mason.nvim",
    profiles: ["lsp"],
    lazy: {
      cmd: "Mason",
    },
  },
  {
    url: "https://github.com/williamboman/mason-lspconfig.nvim",
    profiles: ["lsp"],
    lazy: {
      enabled: true,
    },
    dependencies: [
      "https://github.com/williamboman/mason.nvim",
    ],
    afterFile: "~/.config/nvim/rc/after/mason-lspconfig.lua",
  },
  {
    url: "https://github.com/zapling/mason-conform.nvim",
    enabled: false,
    profiles: ["lsp"],
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
    profiles: ["lsp"],
    dependencies: [
      "https://github.com/neovim/nvim-lspconfig",
      "https://github.com/SmiteshP/nvim-navic",
    ],
    lazy: {
      ft: ["rust", "toml"],
    },
    afterFile: "~/.config/nvim/rc/after/rustaceanvim.lua",
  },
  {
    url: "https://github.com/alexpasmantier/krust.nvim",
    profiles: ["lsp"],
    lazy: {
      ft: ["rust", "toml"],
    },
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
    profiles: ["core"],
    lazy: {
      cmd: "Trouble",
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("trouble").setup()`);
    },
  },
  {
    url: "https://github.com/neovim/nvim-lspconfig",
    profiles: ["lsp"],
    lazy: {
      event: ["BufRead", "BufNewFile"],
    },
    dependencies: selections.completion === "blink"
      ? [...lspDependencies, "https://github.com/saghen/blink.cmp"]
      : selections.completion === "cmp"
      ? [...lspDependencies, "https://github.com/hrsh7th/nvim-cmp"]
      : lspDependencies,
    after: async ({ denops }) => {
      if (selections.completion === "cmp") {
        return await execute(
          denops,
          `
lua << EOB
vim.lsp.config('*', {
  root_markers = { '.git' },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
EOB
          `,
        );
      }
      if (selections.completion === "blink") {
        return await execute(
          denops,
          `
lua << EOB
vim.lsp.config('*', {
  root_markers = { '.git' },
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
EOB
          `,
        );
      }
      return await execute(
        denops,
        `
lua << EOB
vim.lsp.config('*', {
  root_markers = { '.git' },
})
EOB
        `,
      );
    },
    afterFile: "~/.config/nvim/rc/after/nvim-lspconfig.lua",
  },
  {
    url: "https://github.com/ThePrimeagen/refactoring.nvim",
    profiles: ["lsp"],
    afterFile: "~/.config/nvim/rc/after/refactoring.lua",
  },
];
