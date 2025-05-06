// =============================================================================
// File        : cmp.ts
// Author      : yukimemi
// Last Change : 2025/05/05 14:02:43.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.0.3";

export const cmp: Plug[] = [
  { url: "https://github.com/hrsh7th/cmp-nvim-lsp", profiles: ["cmp"] },
  { url: "https://github.com/hrsh7th/cmp-buffer", profiles: ["cmp"] },
  { url: "https://github.com/hrsh7th/cmp-emoji", profiles: ["cmp"] },
  { url: "https://github.com/hrsh7th/cmp-cmdline", profiles: ["cmp"] },
  { url: "https://github.com/dmitmel/cmp-cmdline-history", profiles: ["cmp"] },
  { url: "https://github.com/hrsh7th/cmp-path", profiles: ["cmp"] },
  { url: "https://github.com/lukas-reineke/cmp-rg", profiles: ["cmp"] },
  { url: "https://github.com/ray-x/cmp-treesitter", profiles: ["cmp"] },
  { url: "https://github.com/chrisgrieser/cmp-nerdfont", profiles: ["cmp"] },
  { url: "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help", profiles: ["cmp"] },
  { url: "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol", profiles: ["cmp"] },
  { url: "https://github.com/uga-rosa/cmp-denippet", profiles: ["cmp"] },
  { url: "https://github.com/uga-rosa/denippet.nvim", profiles: ["cmp"] },
  { url: "https://github.com/teramako/cmp-cmdline-prompt.nvim", profiles: ["cmp"] },
  {
    url: "https://github.com/KentoOgata/cmp-tsnip",
    profiles: ["cmp"],
    enabled: false,
  },
  {
    url: "https://github.com/yuki-yano/tsnip.nvim",
    profiles: ["cmp"],
    enabled: false,
  },
  {
    url: "https://github.com/hrsh7th/nvim-cmp",
    profiles: ["cmp"],
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
