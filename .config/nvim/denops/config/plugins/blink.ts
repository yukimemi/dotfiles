// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2025/09/08 00:08:45.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";
import { execCommand } from "../util.ts";

export const blink: Plug[] = [
  {
    url: "https://github.com/Saghen/blink.cmp",
    rev: "v1.6.0",
    profiles: ["completion"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.cmp.lua`,
  },
  {
    url: "https://github.com/Saghen/blink.pairs",
    profiles: ["default"],
    afterFile: "~/.config/nvim/rc/after/blink.pairs.lua",
    build: async ({ denops, info }) => {
      if (info.isLoad && info.isUpdate) {
        await execCommand(denops, "cargo", ["build", "--release"], info.dst);
      }
    },
  },
];
