// =============================================================================
// File        : cmp.ts
// Author      : yukimemi
// Last Change : 2024/08/31 01:17:29.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";
import { pluginStatus } from "../pluginstatus.ts";

export const cmp: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-cmp",
    enabled: pluginStatus.cmp && !pluginStatus.vscode,
    dependencies: [
      { url: "https://github.com/hrsh7th/cmp-nvim-lsp" },
      { url: "https://github.com/hrsh7th/cmp-buffer" },
      { url: "https://github.com/hrsh7th/cmp-emoji" },
      { url: "https://github.com/hrsh7th/cmp-cmdline" },
      { url: "https://github.com/dmitmel/cmp-cmdline-history" },
      { url: "https://github.com/hrsh7th/cmp-path" },
      { url: "https://github.com/hrsh7th/cmp-vsnip" },
      { url: "https://github.com/lukas-reineke/cmp-rg" },
      { url: "https://github.com/ray-x/cmp-treesitter" },
      {
        url: "https://github.com/yutkat/cmp-mocword",
        enabled: false,
      },
      { url: "https://github.com/chrisgrieser/cmp-nerdfont" },
      { url: "https://github.com/rafamadriz/friendly-snippets" },
      { url: "https://github.com/onsails/lspkind.nvim" },
      { url: "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help" },
      {
        url: "https://github.com/KentoOgata/cmp-tsnip",
        dependencies: [
          { url: "https://github.com/yuki-yano/tsnip.nvim" },
          { url: "https://github.com/hrsh7th/nvim-cmp" },
        ],
      },
      { url: "https://github.com/hrsh7th/vim-vsnip-integ" },
      {
        url: "https://github.com/hrsh7th/vim-vsnip",
        afterFile: `~/.config/nvim/rc/after/vim-vsnip.vim`,
      },
      { url: "https://github.com/teramako/cmp-cmdline-prompt.nvim" },
    ],
    afterFile: `~/.config/nvim/rc/after/nvim-cmp.lua`,
  },
];
