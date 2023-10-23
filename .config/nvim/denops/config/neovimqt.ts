// =============================================================================
// File        : neovimqt.ts
// Author      : yukimemi
// Last Change : 2023/10/23 20:17:38.
// =============================================================================

import type { Denops } from "https://deno.land/x/denops_std@v5.0.1/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";

export async function setNeovimQt(denops: Denops) {
  if (await fn.exists(denops, ":GuiFont")) {
    // await execute(denops, "GuiFont! HackGen Console NF:h10");
    await execute(denops, "GuiFont! PlemolJP Console NF:h10");
  }
  if (await fn.exists(denops, ":GuiTabline")) {
    await execute(denops, "GuiTabline 0");
  }
  if (await fn.exists(denops, ":GuiPopupmenu")) {
    await execute(denops, "GuiPopupmenu 0");
  }
  if (await fn.exists(denops, ":GuiScrollBar")) {
    await execute(denops, "GuiScrollBar 0");
  }
  if (await fn.exists(denops, ":GuiWindowOpacity")) {
    await execute(denops, "GuiWindowOpacity 0.95");
  }
}
