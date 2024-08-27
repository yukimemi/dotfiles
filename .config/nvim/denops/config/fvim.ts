// =============================================================================
// File        : fvim.ts
// Author      : yukimemi
// Last Change : 2023/12/03 18:43:23.
// =============================================================================

import type { Denops } from "jsr:@denops/std@7.1.0";

import * as fn from "jsr:@denops/std@7.1.0/function";
import * as mapping from "jsr:@denops/std@7.1.0/mapping";
import * as option from "jsr:@denops/std@7.1.0/option";
import { batch } from "jsr:@denops/std@7.1.0/batch";
import { execute } from "jsr:@denops/std@7.1.0/helper";

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
