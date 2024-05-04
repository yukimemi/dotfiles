// =============================================================================
// File        : treesitter.ts
// Author      : yukimemi
// Last Change : 2024/03/17 12:39:03.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.11.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v6.4.0/mapping/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const treesitter: Plug[] = [
  {
    url: "https://github.com/nvim-treesitter/nvim-treesitter",
    enabled: !pluginStatus.vscode,
    afterFile: "~/.config/nvim/rc/after/nvim-treesitter.lua",
  },
  {
    url: "https://github.com/yioneko/nvim-yati",
    dependencies: [{ url: "https://github.com/nvim-treesitter/nvim-treesitter" }],
    enabled: !pluginStatus.vscode,
    afterFile: "~/.config/nvim/rc/after/nvim-yati.lua",
  },
  {
    url: "https://github.com/nvim-treesitter/nvim-treesitter-context",
    dependencies: [{ url: "https://github.com/nvim-treesitter/nvim-treesitter" }],
    enabled: !pluginStatus.vscode,
    afterFile: "~/.config/nvim/rc/after/nvim-treesitter-context.lua",
  },
  {
    url: "https://github.com/windwp/nvim-ts-autotag",
    enabled: !pluginStatus.vscode,
    dependencies: [{ url: "https://github.com/nvim-treesitter/nvim-treesitter" }],
    afterFile: "~/.config/nvim/rc/after/nvim-ts-autotag.lua",
  },
  {
    url: "https://github.com/monaqa/nvim-treesitter-clipping",
    enabled: !pluginStatus.vscode,
    dependencies: [
      { url: "https://github.com/nvim-treesitter/nvim-treesitter" },
      { url: "https://github.com/thinca/vim-partedit" },
    ],
    after: async ({ denops }) => {
      await mapping.map(
        denops,
        "<space>C",
        "<Plug>(ts-clipping-clip)",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<space>C",
        "<Plug>(ts-clipping-select)",
        { mode: ["x", "o"] },
      );
    },
  },
  {
    url: "https://github.com/HiPhish/rainbow-delimiters.nvim",
    enabled: !pluginStatus.vscode,
    dependencies: [{ url: "https://github.com/nvim-treesitter/nvim-treesitter" }],
  },
  {
    url: "https://github.com/4513ECHO/treesitter-compat-highlights.nvim",
    dependencies: [{ url: "https://github.com/nvim-treesitter/nvim-treesitter" }],
    afterFile: "~/.config/nvim/rc/after/treesitter-compat-highlights.lua",
  },
];
