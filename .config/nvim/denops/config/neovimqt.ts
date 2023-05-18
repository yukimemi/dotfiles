import type { Denops } from "./dep.ts";
import { execute, exists } from "./dep.ts";

export async function setNeovimQt(denops: Denops) {
  if (await exists(denops, ":GuiFont")) {
    await execute(denops, "GuiFont! HackGen Console NF:h10");
  }
  if (await exists(denops, ":GuiTabline")) {
    await execute(denops, "GuiTabline 0");
  }
  if (await exists(denops, ":GuiPopupmenu")) {
    await execute(denops, "GuiPopupmenu 0");
  }
  if (await exists(denops, ":GuiScrollBar")) {
    await execute(denops, "GuiScrollBar 0");
  }
  if (await exists(denops, ":GuiWindowOpacity")) {
    await execute(denops, "GuiWindowOpacity 0.95");
  }
}
