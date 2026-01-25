// =============================================================================
// File        : search.ts
// Author      : yukimemi
// Last Change : 2026/01/03 23:07:26.
// =============================================================================

import * as mapping from "@denops/std/mapping";
import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus } from "../pluginstatus.ts";

export const search: Plug[] = [
  {
    url: "https://github.com/lambdalisue/vim-reword",
    enabled: false,
    profiles: ["search"],
  },
  {
    url: "https://github.com/haya14busa/vim-asterisk",
    profiles: ["core"],
  },
  {
    url: "https://github.com/monaqa/modesearch.nvim",
    enabled: pluginStatus.modesearch,
    profiles: ["search"],
    afterFile: "~/.config/nvim/rc/after/modesearch.lua",
  },
  {
    url: "https://github.com/lambdalisue/vim-kensaku",
    profiles: ["core"],
  },
  {
    url: "https://github.com/lambdalisue/vim-kensaku-search",
    enabled: false,
    profiles: ["search"],
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
    profiles: ["search"],
    dependencies: [
      "https://github.com/haya14busa/vim-asterisk",
    ],
    afterFile: "~/.config/nvim/rc/after/nvim-hlslens.lua",
  },
  {
    url: "https://github.com/nvim-pack/nvim-spectre",
    enabled: false,
    profiles: ["search"],
    afterFile: "~/.config/nvim/rc/after/nvim-spectre.lua",
  },
  {
    url: "https://github.com/cshuaimin/ssr.nvim",
    enabled: false,
    profiles: ["search"],
    afterFile: "~/.config/nvim/rc/after/ssr.lua",
  },
  {
    url: "https://github.com/MagicDuck/grug-far.nvim",
    profiles: ["search"],
    afterFile: "~/.config/nvim/rc/after/grug-far.lua",
  },
];
