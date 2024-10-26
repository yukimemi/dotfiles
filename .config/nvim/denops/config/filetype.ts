// =============================================================================
// File        : filetype.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:39:11.
// =============================================================================

import type { Denops } from "jsr:@denops/std@7.3.0";

import { batch } from "jsr:@denops/std@7.3.0/batch";
import * as autocmd from "jsr:@denops/std@7.3.0/autocmd";
import * as vars from "jsr:@denops/std@7.3.0/variable";

export async function setFiletype(denops: Denops) {
  await batch(denops, async (denops: Denops) => {
    await vars.g.set(denops, "xml_syntax_folding", 1);
    await autocmd.group(denops, "MyXml", (helper) => {
      helper.remove("*");
      helper.define("FileType", "xml", "setl foldmethod=syntax");
    });
  });
}
