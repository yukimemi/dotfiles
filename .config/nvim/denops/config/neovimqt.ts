// =============================================================================
// File        : neovimqt.ts
// Author      : yukimemi
// Last Change : 2024/07/27 22:30:45.
// =============================================================================

import type { Denops } from "jsr:@denops/std@7.6.0";
import { execute } from "jsr:@denops/std@7.6.0/helper";
import * as fn from "jsr:@denops/std@7.6.0/function";

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
