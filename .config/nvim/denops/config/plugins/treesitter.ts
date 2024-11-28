// =============================================================================
// File        : treesitter.ts
// Author      : yukimemi
// Last Change : 2024/10/14 19:28:15.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.2.2";

import * as mapping from "jsr:@denops/std@7.4.0/mapping";

export const treesitter: Plug[] = [
  {
    url: "https://github.com/nvim-treesitter/nvim-treesitter",
    build: async ({ denops, info }) => {
      if (!info.isLoad || !info.isUpdate) {
        return;
      }
      await denops.cmd("TSUpdate");
    },
    afterFile: "~/.config/nvim/rc/after/nvim-treesitter.lua",
  },
  {
    url: "https://github.com/yioneko/nvim-yati",
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    afterFile: "~/.config/nvim/rc/after/nvim-yati.lua",
  },
  {
    url: "https://github.com/nvim-treesitter/nvim-treesitter-context",
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    afterFile: "~/.config/nvim/rc/after/nvim-treesitter-context.lua",
  },
  {
    url: "https://github.com/windwp/nvim-ts-autotag",
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    afterFile: "~/.config/nvim/rc/after/nvim-ts-autotag.lua",
  },
  {
    url: "https://github.com/monaqa/nvim-treesitter-clipping",
    dependencies: [
      "https://github.com/nvim-treesitter/nvim-treesitter",
      "https://github.com/thinca/vim-partedit",
    ],
    after: async ({ denops }) => {
      await mapping.map(denops, "<space>C", "<Plug>(ts-clipping-clip)", { mode: "n" });
      await mapping.map(denops, "<space>C", "<Plug>(ts-clipping-select)", { mode: ["x", "o"] });
    },
  },
  {
    url: "https://github.com/HiPhish/rainbow-delimiters.nvim",
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
  },
  {
    url: "https://github.com/4513ECHO/treesitter-compat-highlights.nvim",
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    afterFile: "~/.config/nvim/rc/after/treesitter-compat-highlights.lua",
  },
  {
    url: "https://github.com/Wansmer/treesj",
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    afterFile: "~/.config/nvim/rc/after/treesj.lua",
  },
  {
    url: "https://github.com/razak17/tailwind-fold.nvim",
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    afterFile: "~/.config/nvim/rc/after/tailwind-fold.lua",
  },
  {
    url: "https://github.com/luckasRanarison/tailwind-tools.nvim",
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    afterFile: "~/.config/nvim/rc/after/tailwind-tools.lua",
  },
];
