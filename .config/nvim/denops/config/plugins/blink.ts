// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2025/03/15 21:31:23.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.0";
import { execCommand } from "../util.ts";

export const blink: Plug[] = [
  {
    url: "https://github.com/Saghen/blink.cmp",
    profiles: ["cmp"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.cmp.lua`,
    build: async ({ denops, info }) => {
      if (info.isLoad && info.isUpdate) {
        await execCommand(denops, "cargo", ["build", "--release"], info.dst);
      }
    },
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
