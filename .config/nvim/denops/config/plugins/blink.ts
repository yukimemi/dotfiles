// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2025/01/02 01:51:00.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.0.1";
import { execCommand } from "../util.ts";

export const blink: Plug[] = [
  {
    url: "https://github.com/Saghen/blink.cmp",
    profiles: ["minimal"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.lua`,
    build: async ({ denops, info }) => {
      if (!info.isLoad) {
        return;
      }
      await execCommand(denops, "cargo", ["build", "--release"], info.dst);
    },
  },
];
