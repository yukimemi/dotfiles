// =============================================================================
// File        : nvy.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:20:10.
// =============================================================================

import type { Denops } from "@denops/std";

import * as fn from "@denops/std/function";
import * as option from "@denops/std/option";

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
