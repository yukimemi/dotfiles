// =============================================================================
// File        : nvy.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:39:41.
// =============================================================================

import type { Denops } from "https://deno.land/x/denops_std@v6.4.2/mod.ts";

import * as option from "https://deno.land/x/denops_std@v6.4.2/option/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v6.4.2/function/mod.ts";

export async function setNvy(denops: Denops) {
  if (!(await fn.exists(denops, "g:nvy"))) {
    return;
  }

  // const fontName = "HackGen Console NF";
  const fontName = "PlemolJP Console NF";

  if (denops.meta.platform === "windows") {
    await option.guifont.set(denops, `${fontName}:h10:#h-none`);
    await option.guifontwide.set(denops, `${fontName}:h10:#h-none`);
  } else {
    await option.guifont.set(denops, `${fontName}:h14:#h-none`);
    await option.guifontwide.set(denops, `${fontName}:h14:#h-none`);
  }
}
