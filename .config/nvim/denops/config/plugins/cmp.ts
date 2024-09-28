// =============================================================================
// File        : cmp.ts
// Author      : yukimemi
// Last Change : 2024/08/31 19:52:04.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.2.0";
import { pluginStatus } from "../pluginstatus.ts";

export const cmp: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-cmp",
    enabled: pluginStatus.cmp && !pluginStatus.vscode,
    dependencies: [
      // source.
      { url: "https://github.com/hrsh7th/cmp-nvim-lsp" },
      { url: "https://github.com/hrsh7th/cmp-buffer" },
      { url: "https://github.com/hrsh7th/cmp-emoji" },
      { url: "https://github.com/hrsh7th/cmp-cmdline" },
      { url: "https://github.com/dmitmel/cmp-cmdline-history" },
      { url: "https://github.com/hrsh7th/cmp-path" },
      { url: "https://github.com/lukas-reineke/cmp-rg" },
      { url: "https://github.com/ray-x/cmp-treesitter" },
      {
        url: "https://github.com/yutkat/cmp-mocword",
        enabled: false,
      },
      { url: "https://github.com/chrisgrieser/cmp-nerdfont" },
      { url: "https://github.com/onsails/lspkind.nvim" },
      { url: "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help" },
      { url: "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol" },
      {
        url: "https://github.com/KentoOgata/cmp-tsnip",
        dependencies: [
          { url: "https://github.com/yuki-yano/tsnip.nvim" },
          { url: "https://github.com/hrsh7th/nvim-cmp" },
        ],
      },
      // snippet.
      {
        url: "https://github.com/hrsh7th/cmp-vsnip",
        enabled: pluginStatus.vsnip,
        dependencies: [
          { url: "https://github.com/hrsh7th/vim-vsnip" },
        ],
      },
      {
        url: "https://github.com/uga-rosa/cmp-denippet",
        enabled: pluginStatus.denippet,
        dependencies: [
          { url: "https://github.com/uga-rosa/denippet.nvim" },
        ],
      },
      // cmdline.
      { url: "https://github.com/teramako/cmp-cmdline-prompt.nvim" },
    ],
    afterFile: `~/.config/nvim/rc/after/nvim-cmp.lua`,
  },
];
