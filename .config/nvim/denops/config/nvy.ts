import type { Denops } from "https://deno.land/x/denops_std@v5.0.1/mod.ts";

import * as option from "https://deno.land/x/denops_std@v5.0.1/option/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";

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
