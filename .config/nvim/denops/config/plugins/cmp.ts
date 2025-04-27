// =============================================================================
// File        : cmp.ts
// Author      : yukimemi
// Last Change : 2025/01/09 20:28:54.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.0.1";

export const cmp: Plug[] = [
  { url: "https://github.com/hrsh7th/cmp-nvim-lsp", profiles: ["default"] },
  { url: "https://github.com/hrsh7th/cmp-buffer", profiles: ["default"] },
  { url: "https://github.com/hrsh7th/cmp-emoji", profiles: ["default"] },
  { url: "https://github.com/hrsh7th/cmp-cmdline", profiles: ["default"] },
  { url: "https://github.com/dmitmel/cmp-cmdline-history", profiles: ["default"] },
  { url: "https://github.com/hrsh7th/cmp-path", profiles: ["default"] },
  { url: "https://github.com/lukas-reineke/cmp-rg", profiles: ["default"] },
  { url: "https://github.com/ray-x/cmp-treesitter", profiles: ["default"] },
  { url: "https://github.com/chrisgrieser/cmp-nerdfont", profiles: ["default"] },
  { url: "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help", profiles: ["default"] },
  { url: "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol", profiles: ["default"] },
  { url: "https://github.com/uga-rosa/cmp-denippet", profiles: ["default"] },
  { url: "https://github.com/uga-rosa/denippet.nvim", profiles: ["default"] },
  { url: "https://github.com/teramako/cmp-cmdline-prompt.nvim", profiles: ["default"] },
  {
    url: "https://github.com/KentoOgata/cmp-tsnip",
    profiles: ["default"],
    enabled: false,
  },
  {
    url: "https://github.com/yuki-yano/tsnip.nvim",
    profiles: ["default"],
    enabled: false,
  },
  {
    url: "https://github.com/hrsh7th/nvim-cmp",
    profiles: ["default"],
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
