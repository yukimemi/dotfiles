// =============================================================================
// File        : neovide.ts
// Author      : yukimemi
// Last Change : 2023/12/03 18:44:16.
// =============================================================================

import type { Denops } from "https://deno.land/x/denops_std@v5.2.0/mod.ts";

import * as option from "https://deno.land/x/denops_std@v5.2.0/option/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.2.0/variable/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.2.0/function/mod.ts";

export async function setNeovide(denops: Denops) {
  if (!(await fn.exists(denops, "g:neovide"))) {
    return;
  }

  // const fontName = "HackGen Console NF";
  const fontName = "PlemolJP Console NF";
  // const fontName = "UDEV Gothic NF";

  await vars.g.set(denops, "neovide_transparency", 0.9);
  await vars.g.set(denops, "neovide_floating_blur_amount_x", 2.0);
  await vars.g.set(denops, "neovide_floating_blur_amount_y", 2.0);
  await vars.g.set(denops, "neovide_remember_window_size", true);
  await vars.g.set(denops, "neovide_profiler", false);
  await vars.g.set(denops, "neovide_input_use_logo", true);
  await vars.g.set(denops, "neovide_cursor_vfx_mode", "railgun");
  await vars.g.set(denops, "neovide_cursor_animate_in_insert_mode", true);
  await vars.g.set(denops, "neovide_cursor_animate_command_line", true);
  if (denops.meta.platform === "windows") {
    await option.guifont.set(denops, `${fontName}:h10:#h-none`);
    await option.guifontwide.set(denops, `${fontName}:h10:#h-none`);
  } else {
    await option.guifont.set(denops, `${fontName}:h14:#h-none`);
    await option.guifontwide.set(denops, `${fontName}:h14:#h-none`);
  }
}
