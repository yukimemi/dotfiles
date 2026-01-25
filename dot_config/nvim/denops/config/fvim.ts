// =============================================================================
// File        : fvim.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:21:06.
// =============================================================================

import type { Denops } from "@denops/std";

import { batch } from "@denops/std/batch";
import * as fn from "@denops/std/function";
import { execute } from "@denops/std/helper";
import * as mapping from "@denops/std/mapping";
import * as option from "@denops/std/option";

export async function setFvim(denops: Denops) {
  if (!(await fn.exists(denops, "g:fvim_loaded"))) {
    return;
  }

  await batch(denops, async (denops: Denops) => {
    // const fontName = "HackGen Console NF";
    const fontName = "PlemolJP Console NF";

    if (denops.meta.platform === "windows") {
      await option.guifont.set(denops, `${fontName}:h10`);
      await option.guifontwide.set(denops, `${fontName}:h10`);
    } else {
      await option.guifont.set(denops, `${fontName}:h14`);
      await option.guifontwide.set(denops, `${fontName}:h14`);
    }

    await mapping.map(denops, "<C-ScrollWheelUp>", `<cmd>set guifont=+<cr>`, {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "<C-ScrollWheelDown>", `<cmd>set guifont=-<cr>`, {
      mode: "n",
      silent: true,
    });

    await execute(
      denops,
      `
        FVimCursorSmoothMove v:true
        FVimCursorSmoothBlink v:true
        FVimBackgroundComposition 'acrylic'
        FVimBackgroundOpacity 0.85
        FVimBackgroundAltOpacity 0.85
        FVimFontAntialias v:true
        FVimFontAutohint v:true
        FVimFontHintLevel 'full'
        FVimFontLigature v:true
        FVimFontLineHeight '+1.0'
        FVimFontSubpixel v:true
        FVimFontNoBuiltinSymbols v:false
      `,
    );
  });
}
