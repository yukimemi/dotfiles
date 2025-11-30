// =============================================================================
// File        : neovimqt.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:20:18.
// =============================================================================

import type { Denops } from "@denops/std";
import * as fn from "@denops/std/function";
import { execute } from "@denops/std/helper";

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
    await execute(denops, "GuiWindowOpacity 0.9");
  }
}
