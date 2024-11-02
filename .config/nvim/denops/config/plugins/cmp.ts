// =============================================================================
// File        : cmp.ts
// Author      : yukimemi
// Last Change : 2024/10/02 00:29:21.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.12";

export const cmp: Plug[] = [
  { url: "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { url: "https://github.com/hrsh7th/cmp-buffer" },
  { url: "https://github.com/hrsh7th/cmp-emoji" },
  { url: "https://github.com/hrsh7th/cmp-cmdline" },
  { url: "https://github.com/dmitmel/cmp-cmdline-history" },
  { url: "https://github.com/hrsh7th/cmp-path" },
  { url: "https://github.com/lukas-reineke/cmp-rg" },
  { url: "https://github.com/ray-x/cmp-treesitter" },
  { url: "https://github.com/chrisgrieser/cmp-nerdfont" },
  { url: "https://github.com/onsails/lspkind.nvim" },
  { url: "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help" },
  { url: "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol" },
  { url: "https://github.com/uga-rosa/cmp-denippet" },
  { url: "https://github.com/uga-rosa/denippet.nvim" },
  { url: "https://github.com/teramako/cmp-cmdline-prompt.nvim" },
  {
    url: "https://github.com/KentoOgata/cmp-tsnip",
    enabled: false,
  },
  {
    url: "https://github.com/yuki-yano/tsnip.nvim",
    enabled: false,
  },
  {
    url: "https://github.com/hrsh7th/nvim-cmp",
    dependencies: [
      "https://github.com/hrsh7th/cmp-nvim-lsp",
      "https://github.com/hrsh7th/cmp-buffer",
      "https://github.com/hrsh7th/cmp-emoji",
      "https://github.com/hrsh7th/cmp-cmdline",
      "https://github.com/dmitmel/cmp-cmdline-history",
      "https://github.com/hrsh7th/cmp-path",
      "https://github.com/lukas-reineke/cmp-rg",
      "https://github.com/ray-x/cmp-treesitter",
      "https://github.com/chrisgrieser/cmp-nerdfont",
      "https://github.com/onsails/lspkind.nvim",
      "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
      "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol",
      "https://github.com/KentoOgata/cmp-tsnip",
      "https://github.com/yuki-yano/tsnip.nvim",
      "https://github.com/uga-rosa/cmp-denippet",
      "https://github.com/uga-rosa/denippet.nvim",
      "https://github.com/teramako/cmp-cmdline-prompt.nvim",
    ],
    afterFile: `~/.config/nvim/rc/after/nvim-cmp.lua`,
  },
];
