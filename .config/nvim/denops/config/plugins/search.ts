// =============================================================================
// File        : search.ts
// Author      : yukimemi
// Last Change : 2024/07/27 22:27:20.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.1.1";
import * as mapping from "jsr:@denops/std@7.1.1/mapping";
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
