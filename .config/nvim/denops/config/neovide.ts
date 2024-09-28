// =============================================================================
// File        : neovide.ts
// Author      : yukimemi
// Last Change : 2024/08/25 10:36:35.
// =============================================================================

import type { Denops } from "jsr:@denops/std@7.2.0";

import * as option from "jsr:@denops/std@7.2.0/option";
import * as vars from "jsr:@denops/std@7.2.0/variable";
import * as fn from "jsr:@denops/std@7.2.0/function";

export async function setNeovide(denops: Denops) {
  if (!(await fn.exists(denops, "g:neovide"))) {
    return;
  }

  // const fontName = "HackGen Console NF";
  // const fontName = "PlemolJP Console NF";
  const fontName = "UDEV Gothic NFLG";

  await vars.g.set(denops, "neovide_transparency", 0.95);
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

  // For performance.
  // await vars.g.set(denops, "neovide_no_idle", true);
  // await vars.g.set(denops, "neovide_refresh_rate", 30);
}
