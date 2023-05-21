import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";

import * as option from "https://deno.land/x/denops_std@v4.3.3/option/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v4.3.3/variable/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";

export async function setNeovide(denops: Denops) {
  if (await fn.exists(denops, "g:neovide")) {
    await globals.set(denops, "neovide_transparency", 0.9);
    await globals.set(denops, "neovide_floating_blur_amount_x", 2.0);
    await globals.set(denops, "neovide_floating_blur_amount_y", 2.0);
    await globals.set(denops, "neovide_remember_window_size", true);
    await globals.set(denops, "neovide_profiler", false);
    await globals.set(denops, "neovide_input_use_logo", true);
    await globals.set(denops, "neovide_cursor_vfx_mode", "railgun");
    await option.guifont.set(denops, "HackGen Console NF:h10:#h-none");
    await option.guifontwide.set(denops, "HackGen Console NF:h10:#h-none");
  }
}
