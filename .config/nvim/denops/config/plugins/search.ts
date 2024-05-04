// =============================================================================
// File        : search.ts
// Author      : yukimemi
// Last Change : 2024/03/23 20:02:15.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.11.0/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v6.4.0/mapping/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const search: Plug[] = [
  { url: "https://github.com/lambdalisue/reword.vim" },
  { url: "https://github.com/haya14busa/vim-asterisk" },
  {
    url: "https://github.com/monaqa/modesearch.nvim",
    enabled: pluginStatus.modesearch,
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
    beforeSourceFile: "~/.config/nvim/rc/beforeSource/nvim-hlslens.lua",
  },
  {
    url: "https://github.com/nvim-pack/nvim-spectre",
    afterFile: "~/.config/nvim/rc/after/nvim-spectre.lua",
  },
  {
    url: "https://github.com/cshuaimin/ssr.nvim",
    afterFile: "~/.config/nvim/rc/after/ssr.lua",
  },
];
