// =============================================================================
// File        : ai.ts
// Last Change : 2024/01/08 02:07:05.
// Last Change : 2024/01/08 02:07:05.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.0/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.2.0/variable/mod.ts";

export const ai: Plug[] = [
  { url: "https://github.com/kyoh86/denops-ollama.vim" },
  {
    url: "https://github.com/yukimemi/futago.vim",
    dst: "~/src/github.com/yukimemi/futago.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "futago_debug", true);
    },
  },
];
