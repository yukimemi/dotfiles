// =============================================================================
// File        : search.ts
// Author      : yukimemi
// Last Change : 2025/03/24 01:07:48.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.0";
import * as mapping from "jsr:@denops/std@7.6.0/mapping";
import { pluginStatus } from "../pluginstatus.ts";

export const search: Plug[] = [
  { url: "https://github.com/lambdalisue/vim-reword" },
  {
    url: "https://github.com/haya14busa/vim-asterisk",
    profiles: ["default"],
  },
  {
    url: "https://github.com/monaqa/modesearch.nvim",
    enabled: pluginStatus.modesearch,
    afterFile: "~/.config/nvim/rc/after/modesearch.lua",
  },
  {
    url: "https://github.com/lambdalisue/vim-kensaku",
    profiles: ["minimal"],
  },
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
    profiles: ["default"],
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
  {
    url: "https://github.com/MagicDuck/grug-far.nvim",
    profiles: ["search"],
    afterFile: "~/.config/nvim/rc/after/grug-far.lua",
  },
];
