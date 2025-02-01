// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2025/01/02 21:53:15.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.2";
import { execCommand } from "../util.ts";

export const blink: Plug[] = [
  {
    url: "https://github.com/Saghen/blink.cmp",
    profiles: ["default"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.lua`,
    build: async ({ denops, info }) => {
      if (info.isLoad && info.isUpdate) {
        await execCommand(denops, "cargo", ["build", "--release"], info.dst);
      }
    },
  },
];
