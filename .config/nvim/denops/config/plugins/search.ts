// =============================================================================
// File        : search.ts
// Author      : yukimemi
// Last Change : 2024/10/14 12:01:07.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.1.2";
import * as mapping from "jsr:@denops/std@7.3.2/mapping";
import { pluginStatus } from "../pluginstatus.ts";

export const search: Plug[] = [
  { url: "https://github.com/lambdalisue/vim-reword" },
  { url: "https://github.com/haya14busa/vim-asterisk" },
  {
    url: "https://github.com/monaqa/modesearch.nvim",
    enabled: pluginStatus.modesearch,
    afterFile: "~/.config/nvim/rc/after/modesearch.lua",
  },
  { url: "https://github.com/lambdalisue/vim-kensaku" },
  {
    url: "https://github.com/lambdalisue/vim-kensaku-search",
    enabled: false,
    dependencies: [
      "https://github.com/lambdalisue/vim-kensaku",
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
      "https://github.com/haya14busa/vim-asterisk",
    ],
    beforeFile: "~/.config/nvim/rc/before/nvim-hlslens.lua",
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
