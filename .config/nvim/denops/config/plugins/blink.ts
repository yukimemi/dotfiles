// =============================================================================
// File        : blink.ts
// Author      : yukimemi
// Last Change : 2024/12/31 10:25:04.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.6.0";
import { execCommand } from "../util.ts";

export const blink: Plug[] = [
  {
    url: "https://github.com/Saghen/blink.cmp",
    profiles: ["minimal"],
    dependencies: ["https://github.com/rafamadriz/friendly-snippets"],
    afterFile: `~/.config/nvim/rc/after/blink.lua`,
    build: async ({ denops, info }) => {
      await execCommand(denops, "cargo", ["build", "--release"], info.dst);
    },
  },
];
