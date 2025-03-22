// =============================================================================
// File        : showinfo.ts
// Author      : yukimemi
// Last Change : 2025/03/19 00:47:15.
// =============================================================================

import * as fn from "jsr:@denops/std@7.5.0/function";
import * as vars from "jsr:@denops/std@7.5.0/variable";
import * as op from "jsr:@denops/std@7.5.0/option";
import type { Denops } from "jsr:@denops/std@7.5.0";
import { notify } from "./util.ts";

export async function notifyinfo(denops: Denops) {
  await notify(denops, [
    "Show info",
    "------------------------------",
    `colorscheme: [${await vars.g.get(denops, "colors_name")}], priority: [${await vars.g.get(
      denops,
      "spectrism_priority",
    )}]`,
    `path: [${await fn.expand(denops, "%:p")}]`,
    `encoding: [${await op.fileencoding.get(denops)}]`,
    `fileformat: [${await op.fileformat.get(denops)}]`,
    `bomb: [${await op.bomb.get(denops)}]`,
  ], { timeout: 60000, type: "snacks" });
}
