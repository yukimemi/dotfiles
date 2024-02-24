// =============================================================================
// File        : search.ts
// Author      : yukimemi
// Last Change : 2024/02/17 11:10:56.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.1/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v6.1.0/mapping/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const search: Plug[] = [
  { url: "https://github.com/lambdalisue/reword.vim" },
  { url: "https://github.com/haya14busa/vim-asterisk" },
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
  {
    url: "https://github.com/kevinhwang91/nvim-hlslens",
    dependencies: [
      { url: "https://github.com/haya14busa/vim-asterisk" },
    ],
    afterFile: "~/.config/nvim/rc/after/nvim-hlslens.lua",
  },
];
