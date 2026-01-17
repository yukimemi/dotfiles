// =============================================================================
// File        : cmp.ts
// Author      : yukimemi
// Last Change : 2026/01/17 21:47:25.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { selections } from "../pluginstatus.ts";

export const cmp: Plug[] = [
  {
    url: "https://github.com/hrsh7th/cmp-nvim-lsp",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/cmp-buffer",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/cmp-emoji",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/cmp-cmdline",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/dmitmel/cmp-cmdline-history",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/cmp-path",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/lukas-reineke/cmp-rg",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/ray-x/cmp-treesitter",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/chrisgrieser/cmp-nerdfont",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/uga-rosa/cmp-denippet",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/uga-rosa/denippet.nvim",
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/teramako/cmp-cmdline-prompt.nvim",
    enabled: selections.completion === "cmp",
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
    enabled: selections.completion === "cmp",
    profiles: ["completion"],
    lazy: {
      event: ["InsertEnter", "CmdlineEnter"],
    },
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
