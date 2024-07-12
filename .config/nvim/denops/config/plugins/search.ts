// =============================================================================
// File        : search.ts
// Author      : yukimemi
// Last Change : 2024/06/15 23:16:17.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.14.7/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v6.5.1/mapping/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const search: Plug[] = [
  { url: "https://github.com/lambdalisue/vim-reword" },
  { url: "https://github.com/haya14busa/vim-asterisk" },
  {
    url: "https://github.com/monaqa/modesearch.nvim",
    enabled: pluginStatus.modesearch,
    afterFile: "~/.config/nvim/rc/after/modesearch.lua",
  },
  {
    url: "https://github.com/lambdalisue/vim-kensaku-search",
    enabled: false,
    dependencies: [
      { url: "https://github.com/lambdalisue/vim-kensaku" },
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
