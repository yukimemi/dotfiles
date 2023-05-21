import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v4.3.3/helper/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";

export async function setNeovimQt(denops: Denops) {
  if (await fn.exists(denops, ":GuiFont")) {
    await execute(denops, "GuiFont! HackGen Console NF:h10");
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
