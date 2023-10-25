// =============================================================================
// File        : fvim.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:39:16.
// =============================================================================

import type { Denops } from "https://deno.land/x/denops_std@v5.0.1/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import * as option from "https://deno.land/x/denops_std@v5.0.1/option/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v5.0.1/batch/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/execute.ts";

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
