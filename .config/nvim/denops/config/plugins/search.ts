// =============================================================================
// File        : search.ts
// Author      : yukimemi
// Last Change : 2023/12/16 12:33:28.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.7.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.2.0/mapping/mod.ts";

import { pluginStatus } from "../pluginstatus.ts";

export const search: Plug[] = [
  { url: "https://github.com/lambdalisue/reword.vim" },
  {
    url: "https://github.com/haya14busa/vim-asterisk",
    after: async ({ denops }) => {
      await mapping.map(denops, "*", "<Plug>(asterisk-z*)zv", {
        mode: ["n", "o", "x"],
      });
      await mapping.map(denops, "g*", "<Plug>(asterisk-gz*)zv", {
        mode: ["n", "o", "x"],
      });
      await mapping.map(denops, "#", "<Plug>(asterisk-z#)zv", {
        mode: ["n", "o", "x"],
      });
      await mapping.map(denops, "g#", "<Plug>(asterisk-gz#)zv", {
        mode: ["n", "o", "x"],
      });
    },
  },
  {
    url: "https://github.com/monaqa/modesearch.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && pluginStatus.modesearch,
    afterFile: "~/.config/nvim/rc/after/modesearch.lua",
  },
  {
    url: "https://github.com/lambdalisue/kensaku-search.vim",
    enabled: false,
    dependencies: [
      { url: "https://github.com/lambdalisue/kensaku.vim" },
    ],
    after: async ({ denops }) => {
      await mapping.map(denops, "<cr>", "<Plug>(kensaku-search-replace)<cr>", {
        mode: "c",
      });
    },
  },
];
