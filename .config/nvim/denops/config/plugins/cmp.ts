// =============================================================================
// File        : cmp.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:18:09.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const cmp: Plug[] = [
  { url: "https://github.com/hrsh7th/cmp-nvim-lsp", profiles: ["completion"] },
  { url: "https://github.com/hrsh7th/cmp-buffer", profiles: ["completion"] },
  { url: "https://github.com/hrsh7th/cmp-emoji", profiles: ["completion"] },
  { url: "https://github.com/hrsh7th/cmp-cmdline", profiles: ["completion"] },
  {
    url: "https://github.com/dmitmel/cmp-cmdline-history",
    profiles: ["completion"],
  },
  { url: "https://github.com/hrsh7th/cmp-path", profiles: ["completion"] },
  { url: "https://github.com/lukas-reineke/cmp-rg", profiles: ["completion"] },
  { url: "https://github.com/ray-x/cmp-treesitter", profiles: ["completion"] },
  {
    url: "https://github.com/chrisgrieser/cmp-nerdfont",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol",
    profiles: ["completion"],
  },
  { url: "https://github.com/uga-rosa/cmp-denippet", profiles: ["completion"] },
  {
    url: "https://github.com/uga-rosa/denippet.nvim",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/teramako/cmp-cmdline-prompt.nvim",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/KentoOgata/cmp-tsnip",
    enabled: false,
    profiles: ["completion"],
  },
  {
    url: "https://github.com/yuki-yano/tsnip.nvim",
    enabled: false,
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/nvim-cmp",
    profiles: ["completion"],
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
